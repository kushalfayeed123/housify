import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Profile extends StatelessWidget {
  final String? address;
  const Profile({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: const [FadeEffect(), ScaleEffect(), SlideEffect()],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/marker.png',
                    width: 20,
                    color: const Color.fromARGB(255, 75, 74, 74),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    address ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ).animate().fade(duration: 2000.ms, delay: 500.ms),
            )
                .animate()
                .fade(
                  duration: 2000.ms,
                  curve: Curves.decelerate,
                )
                .slide(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 25,
              child: Image.asset(
                'assets/images/generic_avatar.png',
                fit: BoxFit.cover,
              ),
            )
                .animate()
                .fade(
                  duration: 2000.ms,
                  curve: Curves.easeOut,
                )
                .scale()
            // .slide(
            //   begin: const Offset(0, 1), // Start from bottom (y=1)
            //   end: Offset.zero,
            // )
          ],
        ));
  }
}
