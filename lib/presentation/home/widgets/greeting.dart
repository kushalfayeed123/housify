import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  final String userGreet;
  final String title;
  const Greeting({super.key, required this.userGreet, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userGreet,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: const Color(0xFF202020), fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: const Color.fromARGB(255, 61, 61, 65),
                fontSize: 45,
                height: 1,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
