import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/parent_dashboard_data.dart';

class DashboardService {
  static final _db = Supabase.instance.client;

  /// Fetches today's learning_sessions for the current user and
  /// aggregates them into a [ParentDashboardData] object.
  static Future<ParentDashboardData> fetchDashboardData() async {
    try {
      final userId = _db.auth.currentUser?.id;
      if (userId == null) {
        debugPrint('DashboardService → no authenticated user');
        return ParentDashboardData.empty();
      }

      // Today's date range (UTC midnight → now)
      final todayStart = DateTime.now().toUtc();
      final startOfDay = DateTime.utc(
        todayStart.year,
        todayStart.month,
        todayStart.day,
      ).toIso8601String();

      final rows = await _db
          .from('learning_sessions')
          .select('lesson_id, subject, score, replays_used, time_spent_seconds, completed')
          .eq('user_id', userId)
          .gte('started_at', startOfDay);

      debugPrint('DashboardService → fetched ${rows.length} sessions today');

      if (rows.isEmpty) return ParentDashboardData.empty();

      int completedCount  = 0;
      int totalSeconds    = 0;
      int totalReplays    = 0;

      // subject → total replays map for weak subject detection
      final Map<String, int> subjectReplays = {};
      final List<String>     recentLessons  = [];

      for (final row in rows) {
        final completed   = (row['completed']          as bool?)   ?? false;
        final seconds     = (row['time_spent_seconds'] as num?)?.toInt() ?? 0;
        final replays     = (row['replays_used']       as num?)?.toInt() ?? 0;
        final subject     = (row['subject']            as String?) ?? '';
        final lessonId    = (row['lesson_id']          as String?) ?? '';

        if (completed) completedCount++;
        totalSeconds += seconds;
        totalReplays += replays;

        if (subject.isNotEmpty) {
          subjectReplays[subject] =
              (subjectReplays[subject] ?? 0) + replays;
        }

        if (lessonId.isNotEmpty && !recentLessons.contains(lessonId)) {
          recentLessons.add(lessonId);
        }
      }

      // Subject with highest replay count = weak subject
      String weakSubject = '—';
      if (subjectReplays.isNotEmpty) {
        weakSubject = subjectReplays.entries
            .reduce((a, b) => a.value >= b.value ? a : b)
            .key;
      }

      return ParentDashboardData(
        lessonsCompletedToday: completedCount,
        totalTimeMinutesToday: (totalSeconds / 60).ceil(),
        totalReplayCountToday: totalReplays,
        weakSubject:           weakSubject,
        recentLessons:         recentLessons.take(5).toList(),
      );
    } catch (e, stack) {
      debugPrint('DashboardService fetchDashboardData ERROR: $e');
      debugPrintStack(stackTrace: stack);
      return ParentDashboardData.empty();
    }
  }
}
