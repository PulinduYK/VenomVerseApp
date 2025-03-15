import 'package:flutter/material.dart';
import 'heat_map_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(6.9271, 79.8612); // Default: Colombo
  Set<Marker> _markers = {};
  Set<Circle> _heatCircles = {};
  HeatMapHandler _heatMapHandler = HeatMapHandler(); // HeatMapHandler instance

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _heatMapHandler.fetchHeatMapData((newMarkers, newHeatCircles) {
      setState(() {
        _markers = newMarkers;
        _heatCircles = newHeatCircles;
      });
    });
  }

  // Request location permission
  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print("Location permission denied");
    }
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 13));
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 13, // Default zoom
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            markers: _markers,
            circles: _heatCircles,
          ),

          // Zoom Buttons
          Positioned(
            bottom: 180,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomIn());
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomOut());
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
          ),

          // Get Location Button
          Positioned(
            bottom: 120,
            right: 20,
            child: FloatingActionButton(
              heroTag: "getLocation",
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.blue,
              child: Icon(Icons.my_location, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
