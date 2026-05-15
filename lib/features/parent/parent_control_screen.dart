
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/router/app_router.dart';
import '../../models/parent_dashboard_data.dart';
import '../../services/analytics/dashboard_service.dart';
import '../../features/parent/parent_settings_service.dart';

class _C {
  static const yellow = Color(0xFFFFD94A);
  static const blue = Color(0xFF4AC8FF);
  static const coral = Color(0xFFFF6B6B);
  static const green = Color(0xFF56CF7E);
  static const bg = Color(0xFFFFF9F0);
  static const dark = Color(0xFF1A1A2E);
  static const muted = Color(0xFF9E9EA8);
  static const white = Colors.white;
}

class ParentControlScreen extends StatefulWidget {
  const ParentControlScreen({super.key});

  @override
  State<ParentControlScreen> createState() =>
      _ParentControlScreenState();
}

class _ParentControlScreenState
    extends State<ParentControlScreen> {

  int mathCount = 4;
  int scienceCount = 7;
  int englishCount = 5;
  int hindiCount = 3;
  int evsCount = 2;

  late Future<ParentDashboardData> _dashboardFuture;
  bool _loadingSettings = true;

  @override
  void initState() {
    super.initState();

    _dashboardFuture = DashboardService.fetchDashboardData();

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings =
        await ParentSettingsService.fetchSettings();

    if (!mounted) return;

    setState(() {
      mathCount = settings.mathWeekly;
      scienceCount = settings.scienceWeekly;
      englishCount = settings.englishWeekly;
      hindiCount = settings.hindiWeekly;
      evsCount = settings.evsWeekly;
      _loadingSettings = false;
    });
  }

  Future<void> _refreshDashboard() async {
    setState(() {
      _dashboardFuture = DashboardService.fetchDashboardData();
    });

    await _loadSettings();
  }

  Future<void> _saveSchedule() async {
    await ParentSettingsService.saveSettings(
      mathWeekly: mathCount,
      scienceWeekly: scienceCount,
      englishWeekly: englishCount,
      hindiWeekly: hindiCount,
      evsWeekly: evsCount,
    );
  }

  Widget _buildRow(
    String subject,
    int value,
    VoidCallback plus,
    VoidCallback minus,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  minus();
                  _saveSchedule();
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                value.toString(),
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              IconButton(
                onPressed: () {
                  plus();
                  _saveSchedule();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        backgroundColor: _C.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.go(AppRoutes.modules),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: _loadingSettings
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    _buildDashboard(),
                    const SizedBox(height: 8),
                    _buildRow(
                      'Math',
                      mathCount,
                      () => setState(() => mathCount++),
                      () => setState(() {
                        if (mathCount > 0) mathCount--;
                      }),
                    ),
                    _buildRow(
                      'Science',
                      scienceCount,
                      () => setState(() => scienceCount++),
                      () => setState(() {
                        if (scienceCount > 0) scienceCount--;
                      }),
                    ),
                    _buildRow(
                      'English',
                      englishCount,
                      () => setState(() => englishCount++),
                      () => setState(() {
                        if (englishCount > 0) englishCount--;
                      }),
                    ),
                    _buildRow(
                      'Hindi',
                      hindiCount,
                      () => setState(() => hindiCount++),
                      () => setState(() {
                        if (hindiCount > 0) hindiCount--;
                      }),
                    ),
                    _buildRow(
                      'EVS',
                      evsCount,
                      () => setState(() => evsCount++),
                      () => setState(() {
                        if (evsCount > 0) evsCount--;
                      }),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () =>
                          context.go(AppRoutes.modules),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _C.green,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Back to Learning',
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDashboard() {
    return FutureBuilder<ParentDashboardData>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        final data =
            snapshot.data ?? ParentDashboardData.empty();

        final loading =
            snapshot.connectionState ==
                ConnectionState.waiting;

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Summary",
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: _C.dark,
              ),
            ),
            const SizedBox(height: 10),
            if (loading)
              const Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator(),
                ),
              )
            else ...[
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon:
                          Icons.check_circle_outline,
                      label: 'Lessons Done',
                      value:
                          '${data.lessonsCompletedToday}',
                      color: _C.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.timer_outlined,
                      label: 'Time (min)',
                      value:
                          '${data.totalTimeMinutesToday}',
                      color: _C.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.replay_rounded,
                      label: 'Replays',
                      value:
                          '${data.totalReplayCountToday}',
                      color: _C.coral,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      icon:
                          Icons.warning_amber_rounded,
                      label: 'Weak Subject',
                      value:
                          _capitalize(data.weakSubject),
                      color: _C.yellow,
                    ),
                  ),
                ],
              ),
              if (data.recentLessons.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  'Recent Lessons',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _C.muted,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children:
                      data.recentLessons.map((id) {
                    return Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _C.white,
                        borderRadius:
                            BorderRadius.circular(10),
                        border: Border.all(
                          color: _C.muted.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Text(
                        id,
                        style: GoogleFonts.nunito(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _C.dark,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Weekly Schedule',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: _C.dark,
              ),
            ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: _C.dark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _C.muted,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty || value == '—') return value;

    return value[0].toUpperCase() +
        value.substring(1).toLowerCase();
  }
}
