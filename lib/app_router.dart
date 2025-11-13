import 'package:go_router/go_router.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/home_page.dart';
import 'pages/following_page.dart';
import 'pages/spaces_page.dart';
import 'pages/profile_page.dart';
import 'pages/notifications_page.dart';
import 'pages/user_profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/space_profile_page.dart';
import 'pages/thread_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/following',
      builder: (context, state) => const FollowingPage(),
    ),
    GoRoute(
      path: '/spaces',
      builder: (context, state) => const SpacesPage(),
    ),
    GoRoute(
      path: '/space/:spaceId',
      builder: (context, state) {
        final spaceId = state.pathParameters['spaceId'] ?? '1';
        return SpaceProfilePage(spaceId: spaceId);
      },
    ),
    GoRoute(
      path: '/thread/:threadId',
      builder: (context, state) {
        final threadId = state.pathParameters['threadId'] ?? '1';
        return ThreadPage(threadId: threadId);
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/user/:username',
      builder: (context, state) {
        final username = state.pathParameters['username'] ?? '';
        return UserProfilePage(username: username);
      },
    ),
  ],
);

