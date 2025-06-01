import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/common/providers/auth_notifier.dart';
import 'package:flutter_riverpod_best_practices/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter_riverpod_best_practices/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

import 'route_const.dart';
import '../../features/auth/presentation/screens/login_info_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import 'go_router_refresh_notifier.dart';

Page<dynamic> _buildPageWithCustomTransition(Widget child) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // from right to left
      const end = Offset.zero;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    child: child,
  );
}

GoRoute defaultTransitionRoute({
  required String path,
  required String name,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder:
        (context, state) =>
            _buildPageWithCustomTransition(builder(context, state)),
  );
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConst.splash,
    refreshListenable: GoRouterRefreshNotifier(authNotifierProvider, ref),

    redirect: (context, state) {
      final authStatus = ref.read(authNotifierProvider);

      final isSplash = state.uri.toString() == RouteConst.splash;
      final isOtpVerification =
          state.uri.toString() == RouteConst.otpVerification;
      final isLogInInfo = state.uri.toString() == RouteConst.loginInfo;
      final isLogIn = state.uri.toString() == RouteConst.login;


      // if (authStatus == AuthStatus.loading) {
      //   return isSplash ? null : RouteConst.splash;
      // }

      final isAuthenticated = authStatus == AuthStatus.authenticated;
      final isLoading = authStatus == AuthStatus.loading;

      if (!isLoading && !isAuthenticated && isOtpVerification) {
        return RouteConst.otpVerification;
      }
      if (!isLoading && !isAuthenticated && isLogInInfo) {
        return RouteConst.loginInfo;
      }

      if (isAuthenticated && (isLogIn || isSplash)) {
        return RouteConst.home;
      }
      if (!isLoading && !isAuthenticated) {
        return RouteConst.login;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: RouteConst.splash,
        name: RouteConst.splash,
        pageBuilder:
            (context, state) =>
                _buildPageWithCustomTransition(const SplashScreen()),
      ),
      GoRoute(
        path: RouteConst.login,
        name: RouteConst.login,
        pageBuilder:
            (context, state) =>
                _buildPageWithCustomTransition(const LoginScreen()),
      ),
      GoRoute(
        path: RouteConst.loginInfo,
        name: RouteConst.loginInfo,

        pageBuilder: (context, state) {
          final extras = state.extra as List<String?>;
          return _buildPageWithCustomTransition(
            LoginInfoScreen(phoneNumber: extras[0]!),
          );
        },
      ),

      GoRoute(
        path: RouteConst.otpVerification,
        name: RouteConst.otpVerification,
        pageBuilder: (context, state) {
          final extras = state.extra as List<String?>;
          return _buildPageWithCustomTransition(
            OtpScreen(phoneNumber: extras[0]!, hash: extras[1]!),
          );
        },
      ),

      GoRoute(
        path: RouteConst.home,
        name: RouteConst.home,
        pageBuilder:
            (context, state) => _buildPageWithCustomTransition(HomeScreen()),
      ),
    ],
  );
});
