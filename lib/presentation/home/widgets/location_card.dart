import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:housify/shared/widgets/animated_address.dart';

class LocationCard extends StatelessWidget {
  final String address;
  final int index;
  const LocationCard({
    super.key,
    required this.address,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          image: const DecorationImage(
            image: AssetImage('assets/images/bg-1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [AnimatedAddressWidget(address: address, index: index)],
        ),
      ).animate().fade(duration: 2000.ms, delay: 3000.ms).slide(
            begin: const Offset(0, 1),
            end: Offset.zero,
            curve: Curves.easeOut,
          ),
    );
  }
}
