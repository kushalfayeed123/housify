import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:housify/core/domain/dtos/location.dto.dart';
import 'package:housify/state/dashboard/dashboard.provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider).value;
    final locationsData = state?.dashboardData?.locations ?? [];
    allMarkers.clear();
    for (var e in locationsData) {
      allMarkers.add(
        Marker(
          point: LatLng(e.latitude ?? 0, e.longitude ?? 0),
          height: 42,
          width: (e.isOpen ?? false) ? 82 : 32,
          child: InkWell(
            onTap: () => toggleLocation(e),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Center(
                child: !(e.isOpen ?? false)
                    ? Image.asset(
                        'assets/images/hotel.png',
                        color: Colors.white,
                        width: 18,
                      )
                    : Text(
                        e.distanceFromCurrent ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialZoom: 10,
            keepAlive: true,
            initialCameraFit: CameraFit.bounds(
              bounds: LatLngBounds(
                const LatLng(6.524379, 3.379206),
                const LatLng(6.527, 3.381),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 88,
                bottom: 192,
              ),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              tileBuilder: _darkModeTileBuilder,
            ),
            MarkerLayer(
                markers: allMarkers.take(locationsData.length).toList()),
          ],
        ),
        Positioned(
          top: 50,
          left: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search,
                        color: Colors.black), // Search icon on the left
                    hintText: 'Search',
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30.0)), // Rounded corners
                      borderSide: BorderSide.none, // No border
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Image.asset(
                    'assets/images/settings-sliders.png',
                    width: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 120,
          left: 8,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.97,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Image.asset(
                          'assets/images/database.png',
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Image.asset(
                          'assets/images/paper-plane.png',
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/align-left.png',
                          width: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'List of variants',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void toggleLocation(LocationDTO location) {
    ref.read(dashboardProvider.notifier).toggleLocation(location);
    setState(() {});
  }

  Widget _darkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.3136, -0.7152, -0.0722, 0, 255, // Red channel
        -0.3136, -0.7152, -0.0722, 0, 255, // Green channel
        -0.3136, -0.7152, -0.0722, 0, 255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }
}
