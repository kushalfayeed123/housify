import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:housify/presentation/home/widgets/analytics.dart';
import 'package:housify/presentation/home/widgets/greeting.dart';
import 'package:housify/presentation/home/widgets/profile.dart';
import 'package:housify/state/dashboard/dashboard.provider.dart';

class HeroWidget extends ConsumerWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider).value;
    final heroState = state?.dashboardData;

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 8,
        left: 15,
        right: 15,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 235, 234, 233),
            Color.fromARGB(255, 255, 225, 208),
            Color.fromARGB(255, 255, 198, 165),
          ],
          stops: [0.3, 0.7, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Profile(address: state?.currentAddress),
          const SizedBox(
            height: 25,
          ),
          Greeting(
            userGreet: heroState?.greetingText ?? '',
            title: heroState?.pageText ?? '',
          ),
          const SizedBox(
            height: 25,
          ),
          Analytics(
            rentCount: heroState?.rentOfferCount ?? '0',
            buyCount: heroState?.buyOfferCount ?? '0',
          )
        ],
      ),
    );
  }
}
