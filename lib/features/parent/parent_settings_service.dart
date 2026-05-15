
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParentSettings {
  final int mathWeekly;
  final int scienceWeekly;
  final int englishWeekly;
  final int hindiWeekly;
  final int evsWeekly;

  const ParentSettings({
    required this.mathWeekly,
    required this.scienceWeekly,
    required this.englishWeekly,
    required this.hindiWeekly,
    required this.evsWeekly,
  });

  factory ParentSettings.defaults() {
    return const ParentSettings(
      mathWeekly: 4,
      scienceWeekly: 7,
      englishWeekly: 5,
      hindiWeekly: 3,
      evsWeekly: 2,
    );
  }

  factory ParentSettings.fromMap(Map<String, dynamic> map) {
    return ParentSettings(
      mathWeekly: (map['math_weekly'] as num?)?.toInt() ?? 4,
      scienceWeekly: (map['science_weekly'] as num?)?.toInt() ?? 7,
      englishWeekly: (map['english_weekly'] as num?)?.toInt() ?? 5,
      hindiWeekly: (map['hindi_weekly'] as num?)?.toInt() ?? 3,
      evsWeekly: (map['evs_weekly'] as num?)?.toInt() ?? 2,
    );
  }
}

class ParentSettingsService {
  static final _db = Supabase.instance.client;

  static Future<ParentSettings> fetchSettings() async {
    try {
      final userId = _db.auth.currentUser?.id;

      if (userId == null) {
        return ParentSettings.defaults();
      }

      final row = await _db
          .from('parent_settings')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (row == null) {
        await _db.from('parent_settings').insert({
          'user_id': userId,
        });

        return ParentSettings.defaults();
      }

      return ParentSettings.fromMap(row);
    } catch (e, stack) {
      debugPrint('ParentSettingsService fetchSettings ERROR: $e');
      debugPrintStack(stackTrace: stack);
      return ParentSettings.defaults();
    }
  }

  static Future<void> saveSettings({
    required int mathWeekly,
    required int scienceWeekly,
    required int englishWeekly,
    required int hindiWeekly,
    required int evsWeekly,
  }) async {
    try {
      final userId = _db.auth.currentUser?.id;

      if (userId == null) return;

      await _db
          .from('parent_settings')
          .update({
            'math_weekly': mathWeekly,
            'science_weekly': scienceWeekly,
            'english_weekly': englishWeekly,
            'hindi_weekly': hindiWeekly,
            'evs_weekly': evsWeekly,
          })
          .eq('user_id', userId);
    } catch (e, stack) {
      debugPrint('ParentSettingsService saveSettings ERROR: $e');
      debugPrintStack(stackTrace: stack);
    }
  }
}
