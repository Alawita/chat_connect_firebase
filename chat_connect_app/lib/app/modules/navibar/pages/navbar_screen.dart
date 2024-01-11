import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/config/theme/my_colors.dart';
import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends ConsumerStatefulWidget {
  const ScaffoldWithBottomNavBar(
      {super.key, required this.child, required this.tabs});
  final Widget child;
  final List<BottomNavigationBarItem> tabs;

  @override
  ConsumerState<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends ConsumerState<ScaffoldWithBottomNavBar> {
  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/${MyNamedRoutes.home}')) {
      return 0;
    }
    if (location.startsWith('/${MyNamedRoutes.locations}')) {
      return 1;
    }
    if (location.startsWith('/${MyNamedRoutes.profile}')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/${MyNamedRoutes.home}');
        break;
      case 1:
        GoRouter.of(context).go('/${MyNamedRoutes.locations}');
        break;
      case 2:
        GoRouter.of(context).go('/${MyNamedRoutes.profile}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.black,
        currentIndex: _calculateSelectedIndex(context),
        items: widget.tabs,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: MyColors.greyscale_500,
        selectedIconTheme: const IconThemeData(color: MyColors.blue),
        unselectedIconTheme: const IconThemeData(color: MyColors.greyscale_500),
        selectedLabelStyle: context.textTheme.bodyMedium
            ?.copyWith(color: MyColors.secondary_500),
        unselectedLabelStyle: context.textTheme.bodyMedium
            ?.copyWith(color: MyColors.greyscale_500),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
