import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Analytics extends StatelessWidget {
  final String rentCount;
  final String buyCount;
  const Analytics({super.key, required this.rentCount, required this.buyCount});

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 172,
            width: 172,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: Theme.of(context).colorScheme.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Buy',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  buyCount,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Offers',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            height: 172,
            width: 172,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Rent',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  rentCount,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 45),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Offers',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ).animate().fade(duration: 2000.ms, delay: 2500.ms).slide(
            begin: const Offset(0, 1),
            end: Offset.zero,
            curve: Curves.easeOut,
          ),
    );
  }
}
