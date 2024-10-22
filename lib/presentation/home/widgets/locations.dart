import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:housify/core/domain/dtos/location.dto.dart';
import 'package:housify/presentation/home/widgets/location_card.dart';

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
