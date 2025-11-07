import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/base_page.dart';
import 'state/map_notifier.dart';
import 'state/map_state.dart';

class MapPage extends BasePage<MapNotifier, MapState> {
  MapPage({super.key}) : super(provider: mapNotifierProvider);
  static const route = '/map';

  GoogleMapController? _controller;

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, MapState state) {
    final restaurantPosition = LatLng(state.latitude, state.longitude);
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (c){ _controller = c; },
          initialCameraPosition: CameraPosition(
            target: restaurantPosition,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('restaurant'),
              position: restaurantPosition,
              infoWindow: const InfoWindow(
                title: 'Restaurant Chez O’Reilly',
                snippet: 'Venez nous rendre visite!',
              ),
            ),
          },
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurant Chez O’Reilly',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '12 Rue des Gourmands, 75000 Paris',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.phone, size: 16, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('+33 1 23 45 67 89'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            mini: true,
            onPressed: () {
              _controller?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: restaurantPosition, zoom: 15),
                ),
              );
            },
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  AppBar? buildAppBar(BuildContext context, WidgetRef ref, MapState? state) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: const Text(
        'CARTE',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
    );
  }

  @override
  Color? buildBackgroundColor(WidgetRef ref, MapState? state) => Colors.white;
}

