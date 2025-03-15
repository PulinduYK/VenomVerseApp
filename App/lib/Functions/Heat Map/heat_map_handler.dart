import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeatMapHandler {
  Set<Marker> markers = {};
  Set<Circle> heatCircles = {};

  void fetchHeatMapData(Function(Set<Marker>, Set<Circle>) updateMap) {
    FirebaseFirestore.instance.collection("locations").snapshots().listen((querySnapshot) {
      Set<Marker> newMarkers = {};
      Set<Circle> newHeatCircles = {};

      for (var doc in querySnapshot.docs) {
        if (!doc.data().containsKey("latitude") || !doc.data().containsKey("longitude") || !doc.data().containsKey("type")) {
          continue;
        }

        double lat = doc["latitude"];
        double lng = doc["longitude"];
        String type = doc["type"];
        LatLng location = LatLng(lat, lng);

        newMarkers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: location,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              type == "insect" ? BitmapDescriptor.hueRed : BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(title: "Reported: $type"),
          ),
        );

        newHeatCircles.add(
          Circle(
            circleId: CircleId(doc.id),
            center: location,
            radius: 50, // 50m radius
            strokeWidth: 2,
            strokeColor: type == "insect" ? Colors.red : Colors.blue,
            fillColor: type == "insect" ? Colors.red.withOpacity(0.3) : Colors.blue.withOpacity(0.3),
          ),
        );
      }

      updateMap(newMarkers, newHeatCircles);
    });
  }
}
