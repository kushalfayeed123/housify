import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? address;
  const Profile({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                address ?? 'Saint Petersburg',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 25,
          child: Image.asset(
            'assets/images/generic_avatar.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
