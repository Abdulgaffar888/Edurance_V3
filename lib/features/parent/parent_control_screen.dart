import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/router/app_router.dart';

// ─────────────────────────────────────────────
//  BRAND TOKENS
// ─────────────────────────────────────────────
class _C {
  static const yellow = Color(0xFFFFD94A);
  static const coral  = Color(0xFFFF6B6B);
  static const green  = Color(0xFF56CF7E);
  static const bg     = Color(0xFFFFF9F0);
  static const dark   = Color(0xFF2D2D3A);
  static const muted  = Color(0xFF9E9EA8);
  static const white  = Colors.white;
}

// ─────────────────────────────────────────────
//  HARDCODED SAMPLE DATA
// ─────────────────────────────────────────────
const _childName  = 'Aarav';
const _totalTime  = '12 mins';

class _LessonRecord {
  final String subjectEmoji;
  final String subject;
  final String topic;
  final bool   completed;

  const _LessonRecord({
    required this.subjectEmoji,
    required this.subject,
    required this.topic,
    required this.completed,
  });
}

const _lessons = <_LessonRecord>[
  _LessonRecord(
    subjectEmoji: '📖',
    subject: 'English',
    topic: 'Letters A – E',
    completed: true,
  ),
  _LessonRecord(
    subjectEmoji: '📖',
    subject: 'English',
    topic: 'Letters F – J',
    completed: true,
  ),
  _LessonRecord(
    subjectEmoji: '📖',
    subject: 'English',
    topic: 'Letters K – O',
    completed: false,
  ),
];

// ─────────────────────────────────────────────
//  PARENT CONTROL SCREEN
// ─────────────────────────────────────────────
class ParentControlScreen extends StatefulWidget {
  const ParentControlScreen({super.key});

  @override
  State<ParentControlScreen> createState() => _ParentControlScreenState();
}

class _ParentControlScreenState extends State<ParentControlScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreetingCard(),
                      const SizedBox(height: 24),
                      _buildProgressSection(),
                      const SizedBox(height: 32),
                      _buildBackLink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────── TOP BAR ────────
  Widget _buildTopBar() {
    return Container(
      color: _C.bg,
      padding: const EdgeInsets.fromLTRB(12, 10, 20, 10),
      child: Row(
        children: [
          // Back button
          SizedBox(
            width: 48,
            height: 48,
            child: Material(
              color: _C.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.go(AppRoutes.modules),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: _C.green,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Title
          Expanded(
            child: Text(
              'Parent Dashboard',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: _C.dark,
              ),
            ),
          ),
          // Family avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _C.yellow.withValues(alpha: 0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: _C.yellow.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: const Center(
              child: Text('👨‍👩‍👦', style: TextStyle(fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }

  // ─────── GREETING CARD ────────
  Widget _buildGreetingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFEEA0), Color(0xFFFFD94A)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _C.yellow.withValues(alpha: 0.40),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: _C.dark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Here's what $_childName learned today",
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _C.dark.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text('🎉', style: const TextStyle(fontSize: 40)),
        ],
      ),
    );
  }

  // ─────── TODAY'S PROGRESS SECTION ────────
  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section heading
        Text(
          "Today's Progress",
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: _C.dark,
          ),
        ),
        const SizedBox(height: 12),

        // Time stat chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _C.green.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _C.green.withValues(alpha: 0.30),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_rounded, size: 16, color: _C.green),
              const SizedBox(width: 8),
              Text(
                'Total time today: $_totalTime',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: _C.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Lesson cards
        ...List.generate(_lessons.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LessonCard(record: _lessons[i], index: i),
          );
        }),
      ],
    );
  }

  // ─────── BACK TO LEARNING LINK ────────
  Widget _buildBackLink() {
    return Center(
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.modules),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '← Back to learning',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _C.muted,
              decoration: TextDecoration.underline,
              decorationColor: _C.muted,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  LESSON CARD WIDGET
// ─────────────────────────────────────────────
class _LessonCard extends StatelessWidget {
  final _LessonRecord record;
  final int           index;

  const _LessonCard({required this.record, required this.index});

  @override
  Widget build(BuildContext context) {
    final chipColor  = record.completed ? _C.green : _C.yellow;
    final chipBg     = chipColor.withValues(alpha: 0.12);
    final chipLabel  = record.completed ? 'Completed' : 'In Progress';
    final chipIcon   = record.completed
        ? Icons.check_circle_rounded
        : Icons.radio_button_checked_rounded;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 350 + index * 100),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 18 * (1 - v)),
          child: child,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _C.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Subject emoji badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  record.subjectEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Subject + topic
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.subject,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _C.muted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    record.topic,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _C.dark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Status chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: chipBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: chipColor.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(chipIcon, size: 14, color: chipColor),
                  const SizedBox(width: 5),
                  Text(
                    chipLabel,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: chipColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
