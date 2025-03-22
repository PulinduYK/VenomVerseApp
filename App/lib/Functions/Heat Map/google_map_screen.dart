import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'heat_map_handler.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(6.9271, 79.8612);
  Set<Marker> _markers = {};
  Set<Circle> _heatCircles = {};
  HeatMapHandler _heatMapHandler = HeatMapHandler();
  String selectedFilter = "all";
  double _currentZoom = 13;
  Timer? _zoomTimer;
  LatLng? _selectedMarker;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _fetchData();
    _startWaveAnimation();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print("⚠ Location permission denied");
    }
  }

  Future<void> _fetchData() async {
    if (_isFetching) return;
    setState(() => _isFetching = true);

    try {
      Map<String, Set<dynamic>> result =
          await _heatMapHandler.fetchHeatMapData(selectedFilter);
      setState(() {
        _markers = result['markers']?.cast<Marker>() ?? {};
        _heatCircles = result['circles']?.cast<Circle>() ?? {};
      });
    } catch (e) {
      print("⚠ Fetch error: $e");
    } finally {
      setState(() => _isFetching = false);
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _mapController
          ?.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 13));
    } catch (e) {
      print("⚠ Error getting location: $e");
    }
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {
      _selectedMarker = position;
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    });
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedMarker = null;
      _mapController?.animateCamera(CameraUpdate.zoomTo(13));
    });
  }

  void _zoomIn() {
    if (_selectedMarker != null) {
      _mapController
          ?.animateCamera(CameraUpdate.newLatLngZoom(_selectedMarker!, 15));
    } else {
      _mapController?.animateCamera(CameraUpdate.zoomIn());
    }
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void _onCameraMove(CameraPosition position) {
    _currentZoom = position.zoom;
    if (_zoomTimer != null && _zoomTimer!.isActive) return;
    _zoomTimer = Timer(Duration(milliseconds: 500), () {
      _updateCircleSize();
    });
  }

  void _updateCircleSize() {
    if (mounted) {
      setState(() {
        _heatCircles = _heatCircles.map((circle) {
          double newRadius = _currentZoom < 8
              ? 300.0
              : (_currentZoom < 11
                  ? 1500.0
                  : (_currentZoom < 14 ? 1000.0 : 500.0));
          return circle.copyWith(radiusParam: newRadius);
        }).toSet();
      });
    }
  }

  void _startWaveAnimation() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _heatCircles = _heatCircles.map((circle) {
            double radius = (circle.radius == 50) ? 70 : 50;
            return circle.copyWith(radiusParam: radius);
          }).toSet();
        });
      }
    });
  }

  void _changeFilter(String type) {
    setState(() {
      selectedFilter = type;
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            onTap: _onMapTapped,
            markers: _markers.map((marker) {
              return marker.copyWith(
                onTapParam: () => _onMarkerTapped(marker.position),
              );
            }).toSet(),
            circles: _heatCircles,
          ),
          Positioned(
            top: 100,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterButton("Spiders", "spider", Colors.deepPurpleAccent),
                _filterButton("Insects", "insect", Colors.deepPurpleAccent),
                _filterButton("Snakes", "snake", Colors.deepPurpleAccent),
                _filterButton("All", "all", Colors.deepPurple),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: _zoomIn,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.remove, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "fetchData",
                  onPressed: _fetchData,
                  backgroundColor:
                      _isFetching ? Colors.purpleAccent : Colors.deepPurple,
                  child: _isFetching
                      ? CircularProgressIndicator(color: Colors.white)
                      : Icon(Icons.refresh, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "getLocation",
                  onPressed: _getCurrentLocation,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.my_location, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String label, String type, Color color) {
    return ElevatedButton(
      onPressed: () => _changeFilter(type),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedFilter == type ? color : Colors.grey,
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
