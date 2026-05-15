class ParentDashboardData {
  final int          lessonsCompletedToday;
  final int          totalTimeMinutesToday;
  final int          totalReplayCountToday;
  final String       weakSubject;
  final List<String> recentLessons;

  const ParentDashboardData({
    required this.lessonsCompletedToday,
    required this.totalTimeMinutesToday,
    required this.totalReplayCountToday,
    required this.weakSubject,
    required this.recentLessons,
  });

  factory ParentDashboardData.empty() {
    return const ParentDashboardData(
      lessonsCompletedToday: 0,
      totalTimeMinutesToday: 0,
      totalReplayCountToday: 0,
      weakSubject:           '—',
      recentLessons:         [],
    );
  }
}
