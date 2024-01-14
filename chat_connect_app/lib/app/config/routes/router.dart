import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/modules/auth/pages/login_page.dart';
import 'package:chat_connect_app/app/modules/auth/pages/register.dart';
import 'package:chat_connect_app/app/modules/auth/pages/spalsh_scree.dart';
import 'package:chat_connect_app/app/modules/home/pages/home_page.dart';
import 'package:chat_connect_app/app/modules/navibar/pages/location_screen.dart';
import 'package:chat_connect_app/app/modules/navibar/pages/navbar_screen.dart';
import 'package:chat_connect_app/app/modules/navibar/pages/profile_screen.dart';
import 'package:chat_connect_app/app/modules/navibar/widgets/bottom_navbar_tabs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRouteKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.login}",
        name: MyNamedRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.register}",
        name: MyNamedRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
      ),

      // GoRoute(
      //     path: "/${MyNamedRoutes.navi}",
      //     name: MyNamedRoutes.navi,
      //     pageBuilder: (context, state) => NoTransitionPage(
      //           key: state.pageKey,
      //           child: ScaffoldWithBottomNavBar(
      //               child: Text(""),
      //               tabs: BottomNavBarTabs.tabs(
      //                   context)), // Replace with your Locations screen
      //         )),
      ShellRoute(
        navigatorKey: shellRouteKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(
            tabs: BottomNavBarTabs.tabs(context),
            child: child,
          );
        },
        routes: [
          // Existing route for home screen
          GoRoute(
            path: "/${MyNamedRoutes.home}",
            name: MyNamedRoutes.home,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: MyHomeScreen(),
            ),
          ),
          // Add new routes for Profile and Locations screens
          GoRoute(
            path: "/${MyNamedRoutes.profile}",
            name: MyNamedRoutes.profile,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfileScreen(), // Replace with your Profile screen
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.locations}",
            name: MyNamedRoutes.locations,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child:
                  const LocationsScreen(), // Replace with your Locations screen
            ),
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
