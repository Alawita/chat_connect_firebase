import 'package:chat_connect_app/app/modules/locations/domain/providers/location_provider.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends ConsumerState<LocationScreen> {
  GoogleMapController? mapController;
  LatLng initialPosition = const LatLng(29.311661, 47.481766);

  @override
  void initState() {
    super.initState();
    ref.read(locationProviders.notifier).checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Map'),
      ),
      body: Container(
        height: 500,
        width: 500,
        child: FutureBuilder(
            future: ref.read(chatsRepositoryProvider).fetchRegisteredUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.data != null) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: 8,
                  ),
                  markers: snapshot.data!
                      .map(
                        (user) => Marker(
                          onTap: () {
                            debugPrint(
                                'lat: ${user.latitude}, long: ${user.longitude}');
                          },
                          markerId: MarkerId(user.userID),
                          position: LatLng(user.latitude, user.longitude),
                        ),
                      )
                      .toSet(),
                  onMapCreated: (controller) => mapController = controller,
                );
              }
              return GoogleMap(
                initialCameraPosition: CameraPosition(target: initialPosition),
                onMapCreated: (controller) => mapController = controller,
              );
            }),
      ),
    );
  }
}
