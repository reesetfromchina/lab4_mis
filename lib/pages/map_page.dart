import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final LatLng eventLocation;

  const MapPage({super.key, required this.eventLocation});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  LatLng? _currentPos;
  final Set<Polyline> _polylines = <Polyline>{};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPos == null
          ? const Center(child: Text("Loading..."))
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.eventLocation,
          zoom: 15,
        ),
        markers: {
          Marker(markerId: MarkerId("_currentLocation"), position: _currentPos!),
          Marker(markerId: MarkerId("eventLocation"), position: widget.eventLocation),
        },
        polylines: _polylines,
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      _locationController.onLocationChanged.listen((LocationData currentLocation) {
        if (currentLocation.latitude != null && currentLocation.longitude != null) {
          setState(() {
            _currentPos = LatLng(currentLocation.latitude!, currentLocation.longitude!);

            _polylines.clear();
            _polylines.add(Polyline(
              polylineId: PolylineId("route"),
              points: [_currentPos!, widget.eventLocation],
              color: Colors.blue,
              width: 5,
            ));
          });
        }
      });
    }
  }
}
