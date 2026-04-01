import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/router/app_router.dart';

class _C {
  static const yellow = Color(0xFFFFD94A);
  static const blue   = Color(0xFF4AC8FF);
  static const coral  = Color(0xFFFF6B6B);
  static const green  = Color(0xFF56CF7E);
  static const bg     = Color(0xFFFFF9F0);
  static const dark   = Color(0xFF1A1A2E);
  static const muted  = Color(0xFF9E9EA8);
  static const white  = Colors.white;
}

class _LessonItem {
  final String emoji;
  final String subject;
  final String topic;
  final bool completed;
  const _LessonItem({
    required this.emoji,
    required this.subject,
    required this.topic,
    required this.completed,
  });
}

const _todaysLessons = [
  _LessonItem(emoji: '📖', subject: 'English', topic: 'Letter A — Apple',   completed: true),
  _LessonItem(emoji: '📖', subject: 'English', topic: 'Letter B — Ball',    completed: true),
  _LessonItem(emoji: '📖', subject: 'English', topic: 'Letter C — Cat',     completed: false),
];

class ParentControlScreen extends StatefulWidget {
  const ParentControlScreen({super.key});

  @override
  State<ParentControlScreen> createState() => _ParentControlScreenState();
}

class _ParentControlScreenState extends State<ParentControlScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double>   _fade;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: FadeTransition(
        opacity: _fade,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFECEC), Color(0xFFFFF9F0)],
              stops: [0.0, 0.32],
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildTopBar()),
                SliverToBoxAdapter(child: _buildGreetingCard()),
                SliverToBoxAdapter(child: _buildTimeChip()),
                SliverToBoxAdapter(child: _buildSectionLabel()),
                SliverToBoxAdapter(child: _buildLessonList()),
                SliverToBoxAdapter(child: _buildBackLink()),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── TOP BAR
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go(AppRoutes.modules),
            child: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: _C.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Parent Dashboard',
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: _C.dark,
              ),
            ),
          ),
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFEBEB), Color(0xFFFFD6D6)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _C.coral.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('👨‍👩‍👧', style: TextStyle(fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }

  // ── GREETING CARD
  Widget _buildGreetingCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF73D6FF), Color(0xFF4AC8FF)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _C.blue.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good job today! 🌟',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: _C.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Here's what Aarav learned",
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _C.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const Text('📚', style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }

  // ── TIME CHIP
  Widget _buildTimeChip() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _C.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _C.green.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_rounded, size: 16, color: _C.green),
                const SizedBox(width: 6),
                Text(
                  'Total time today: 12 mins',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _C.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── SECTION LABEL
  Widget _buildSectionLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        "Today's Progress",
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: _C.dark,
        ),
      ),
    );
  }

  // ── LESSON LIST
  Widget _buildLessonList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _todaysLessons.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _C.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    color: _C.blue.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(item.emoji,
                        style: const TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.subject,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _C.muted,
                        ),
                      ),
                      Text(
                        item.topic,
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _C.dark,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: item.completed
                        ? _C.green.withValues(alpha: 0.12)
                        : _C.yellow.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.completed ? 'Completed' : 'In Progress',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: item.completed ? _C.green : const Color(0xFFB8860B),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── BACK LINK
  Widget _buildBackLink() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.modules),
        child: Center(
          child: Text(
            '← Back to learning',
            style: GoogleFonts.nunito(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _C.muted,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}