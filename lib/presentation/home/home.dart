import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housify/presentation/home/widgets/hero.dart';
import 'package:housify/presentation/home/widgets/locations.dart';
import 'package:housify/state/dashboard/dashboard.provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final locationState =
        ref.watch(dashboardProvider).value?.dashboardData?.locations;
    return SingleChildScrollView(
        child: Column(
      children: [
        Stack(
          children: [
            const HeroWidget(),
            Positioned(
                height: 60,
                top: MediaQuery.of(context).size.height * 0.59,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18))),
                )),
          ],
        ),
        LocationsWidget(
          locations: locationState ?? [],
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    ));
  }
}
