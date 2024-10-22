import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  String selectedItem = '';

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
            )
                .animate()
                .fade(
                  duration: 1200.ms,
                  curve: Curves.easeOut,
                )
                .scale(),
          ),
        ),
      );
    }

    return Animate(
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              keepAlive: true,
              initialCameraFit: CameraFit.bounds(
                bounds: LatLngBounds(
                  const LatLng(6.5285,
                      3.3790), // Adjusted northernmost and westernmost point
                  const LatLng(6.5265, 3.3840),
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
              Animate(
                child: MarkerLayer(
                    markers: allMarkers.take(locationsData.length).toList()),
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 8,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
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
                    )
                        .animate()
                        .fade(duration: 1200.ms, curve: Curves.easeOut)
                        .scale(),
                  ),
                  const SizedBox(
                    width: 12,
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
                      .animate()
                      .fade(duration: 1200.ms, curve: Curves.easeOut)
                      .scale(),
                ],
              ),
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
                      const AnimatedMenu(),
                      const SizedBox(
                        height: 10,
                      ),
                      IconButton(
                        icon: Container(
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
                        ),
                        onPressed: () {},
                      )
                    ],
                  )
                      .animate()
                      .fade(duration: 1200.ms, curve: Curves.easeOut)
                      .scale(),
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
                  )
                      .animate()
                      .fade(duration: 1200.ms, curve: Curves.easeOut)
                      .scale(),
                ],
              ),
            ),
          )
        ],
      ),
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

class PopMenuItem {
  String? title;
  String? image;
  PopMenuItem({this.title, this.image});
}

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  AnimatedMenuState createState() => AnimatedMenuState();
}

class AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _animationController;

  final menuItems = [
    PopMenuItem(title: 'Cosy areas', image: 'assets/images/shield-check.png'),
    PopMenuItem(title: 'Price', image: 'assets/images/wallet.png'),
    PopMenuItem(title: 'Infrastructure', image: 'assets/images/bridge.png'),
    PopMenuItem(
        title: 'Without any layer', image: 'assets/images/database.png'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void _toggleMenu(MenuController controller) {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
        controller.open();
      } else {
        _animationController.reverse();
        controller.close();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white)),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            _toggleMenu(controller);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/database.png',
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
          tooltip: 'Show menu',
        );
      },
      menuChildren: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _animationController.value,
              child: Opacity(
                opacity: _animationController.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: menuItems
                      .map((e) => MenuItemButton(
                            onPressed: () => _toggleMenu,
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    e.image ?? '',
                                    width: 15,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(e.title ?? '')
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
