import 'dart:ui';

import 'package:flutter/material.dart';

class LocationsWidget extends StatelessWidget {
  const LocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];
    return Column(
      children: [
        const LocationCard(
          address: 'Broadway str ... 12',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row after the first
                childAspectRatio: 1.0, // Aspect ratio for the two-card rows
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                // Other cards are arranged two per row
                return const LocationCard(
                  address: 'Brod str',
                );
              }),
        ),
      ],
    );
  }
}

class LocationCard extends StatelessWidget {
  final String address;
  const LocationCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/bg-1.jpg'), fit: BoxFit.fill)),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Blur effect

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black45, fontWeight: FontWeight.w800),
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Center(
                        child:
                            Image.asset('assets/images/angle-small-right.png'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
