import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housify/shared/models/bottom_nav_item.model.dart';
import 'package:housify/state/dashboard/dashboard.provider.dart';

List<BottomNavItem> bottomNavItems = [
  BottomNavItem(
      text: 'Map',
      icon: "search.png",
      iconActive: 'search.png',
      isActive: false),
  BottomNavItem(
      text: 'Chat',
      icon: "comment-alt-dots.png",
      iconActive: 'comment-alt-dots.png',
      isActive: false),
  BottomNavItem(
      text: 'home',
      icon: "house-chimney-window.png",
      iconActive: 'house-chimney-window.png',
      isActive: false),
  BottomNavItem(
      text: 'Favourite',
      icon: "heart.png",
      isActive: false,
      iconActive: 'heart.png'),
  BottomNavItem(
      text: 'Profile',
      icon: "user.png",
      isActive: false,
      iconActive: 'user.png'),
];

class ScaffoldWithNestedNavigation extends ConsumerStatefulWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;
  @override
  ConsumerState<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends ConsumerState<ScaffoldWithNestedNavigation> {
  @override
  void initState() {
    super.initState();
    ref.read<Dashboard>(dashboardProvider.notifier).fetchDashboardData();
    ref.read<Dashboard>(dashboardProvider.notifier).getUserLocation();

    bottomNavItems
        .firstWhere(
          (e) => e.text == 'home',
          orElse: () => BottomNavItem(
              text: '', icon: '', iconActive: '', isActive: false),
        )
        .isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(dashboardProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: widget.navigationShell),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(50)),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.transparent,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: bottomNavItems
              .map((item) => BottomNavigationBarItem(
                  icon: CircleAvatar(
                      radius: item.isActive ? 25 : 20,
                      backgroundColor: item.isActive
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black12.withOpacity(0.6),
                      child: Image.asset(
                        'assets/images/${item.isActive ? item.iconActive : item.icon}',
                        color: Colors.white,
                        width: 15,
                      )),
                  backgroundColor: Colors.transparent,
                  label: item.text))
              .toList(),
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (int index) => _goBranch(index, ref),
        ),
      ),
    );
  }

  _goBranch(int index, WidgetRef ref) {
    // ref.read(dashboardProvider.notifier).fetchDashboardData();
    // ref.read(dashboardProvider.notifier).getUserLocation();

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );

    setState(() {
      for (var element in bottomNavItems) {
        if (element == bottomNavItems[index]) {
          element.isActive = true;
        } else {
          element.isActive = false;
        }
      }
    });
  }
}
