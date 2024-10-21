import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:housify/core/domain/dtos/location.dto.dart';

class LocationsWidget extends StatelessWidget {
  final List<LocationDTO> locations;
  const LocationsWidget({
    super.key,
    required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4, // Grid with 4 cells in each row
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(locations.length, (index) {
        if (index == 0) {
          // First item spans the entire row
          return StaggeredGridTile.count(
            crossAxisCellCount: 4, // Takes up the full row
            mainAxisCellCount: 2, // Double height
            child: LocationCard(
              address: locations[0].address ?? '',
              index: 0,
            ),
          );
        } else {
          // Subsequent items take up half the row
          return StaggeredGridTile.count(
            crossAxisCellCount: 2, // Takes half the row
            mainAxisCellCount: 2, // Double height
            child: LocationCard(
              address: locations[index].address ?? '',
              index: index,
            ),
          );
        }
      }),
    );
  }
}

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
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Blur effect
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      SizedBox(
                        width: index == 0 ? null : 50,
                        child: Center(
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2),
                          ),
                        ),
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
                          child: Image.asset(
                              'assets/images/angle-small-right.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fade(duration: 2000.ms, delay: 3000.ms).slide(
            begin: const Offset(0, 1),
            end: Offset.zero,
            curve: Curves.easeOut,
          ),
    );
  }
}
