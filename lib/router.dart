import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:housify/presentation/chat/chat.dart';
import 'package:housify/presentation/favorite/favorite.dart';
import 'package:housify/presentation/home/home.dart';
import 'package:housify/presentation/map/map.dart';
import 'package:housify/presentation/settings/settings.dart';
import 'package:housify/shared/widgets/scaffold_with_nested_navigation.dart';

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeShell');
  final shellNavigatorMapKey =
      GlobalKey<NavigatorState>(debugLabel: 'mapShell');
  final shellNavigatorChatKey =
      GlobalKey<NavigatorState>(debugLabel: 'chatShell');
  final shellNavigatorFavoriteKey =
      GlobalKey<NavigatorState>(debugLabel: 'favoriteShell');
  final shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileShell');

  final router = GoRouter(
      initialLocation: '/home',
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                key: UniqueKey(),
                child: const SizedBox(),
                reverseTransitionDuration: const Duration(seconds: 1),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0.75, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeIn)),
                    ),
                    child: child,
                  );
                });
          },
        ),
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ScaffoldWithNestedNavigation(
                  navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(navigatorKey: shellNavigatorMapKey, routes: [
                GoRoute(
                  path: '/map',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                        key: UniqueKey(),
                        child: const MapScreen(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            child: child,
                          );
                        });
                  },
                ),
              ]),
              StatefulShellBranch(navigatorKey: shellNavigatorChatKey, routes: [
                GoRoute(
                  path: '/chat',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                        key: UniqueKey(),
                        child: const Chat(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            child: child,
                          );
                        });
                  },
                ),
              ]),
              StatefulShellBranch(navigatorKey: shellNavigatorHomeKey, routes: [
                GoRoute(
                  path: '/home',
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                        key: UniqueKey(),
                        child: const Home(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn)),
                            ),
                            child: child,
                          );
                        });
                  },
                ),
              ]),
              StatefulShellBranch(
                  navigatorKey: shellNavigatorFavoriteKey,
                  routes: [
                    GoRoute(
                      path: '/favorite',
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                            key: UniqueKey(),
                            child: const Favorite(),
                            transitionDuration: const Duration(seconds: 1),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                  position: animation.drive(Tween<Offset>(
                                begin: const Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn))));
                            });
                      },
                    ),
                  ]),
              StatefulShellBranch(
                  navigatorKey: shellNavigatorProfileKey,
                  routes: [
                    GoRoute(
                      path: '/profile',
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                            key: UniqueKey(),
                            child: const Settings(),
                            transitionDuration: const Duration(seconds: 1),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                  position: animation.drive(Tween<Offset>(
                                begin: const Offset(0.75, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeIn))));
                            });
                      },
                    ),
                  ]),
            ]),
      ]);
  return router;
});
