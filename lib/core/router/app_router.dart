import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/signup_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/learning/modules_screen.dart';
import '../../features/learning/teaching_screen.dart';
import '../../features/parent/parent_control_screen.dart';

abstract final class AppRoutes {
  static const signup = '/signup';
  static const login = '/login';

  static const modules = '/modules';
  static const teaching = '/teaching';
  static const parentControl = '/parent-control';
}

final appRouter = GoRouter(
  initialLocation:
      Supabase.instance.client.auth.currentSession != null
          ? AppRoutes.modules
          : AppRoutes.signup,

  debugLogDiagnostics: true,

  routes: [
    GoRoute(
      path: AppRoutes.signup,
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.modules,
      name: 'modules',
      builder: (context, state) => const ModulesScreen(),
    ),
    GoRoute(
      path: AppRoutes.teaching,
      name: 'teaching',
      builder: (context, state) => const TeachingScreen(),
    ),
    GoRoute(
      path: AppRoutes.parentControl,
      name: 'parent-control',
      builder: (context, state) => const ParentControlScreen(),
    ),
  ],
);