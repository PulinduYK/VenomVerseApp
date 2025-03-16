import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeatMapHandler {
  Future<Map<String, Set<dynamic>>> fetchHeatMapData(String filter) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("locations").get();
    Set<Marker> newMarkers = {};
    Set<Circle> newHeatCircles = {};

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey("latitude") || !data.containsKey("longitude") || !data.containsKey("type")) {
        continue;
      }

      String type = data["type"] ?? "unknown";
      if (filter != "all" && filter != type) continue;

      double lat = data["latitude"] ?? 0.0;
      double lng = data["longitude"] ?? 0.0;
      LatLng location = LatLng(lat, lng);

      Color circleColor = (type == "spider") ? Colors.orange : (type == "insect") ? Colors.red : Colors.blue;
      double hueValue = (type == "spider") ? BitmapDescriptor.hueOrange : (type == "insect") ? BitmapDescriptor.hueRed : BitmapDescriptor.hueBlue;

      newMarkers.add(Marker(
        markerId: MarkerId(doc.id),
        position: location,
        icon: BitmapDescriptor.defaultMarkerWithHue(hueValue),
        infoWindow: InfoWindow(title: "Reported: $type"),
      ));

      newHeatCircles.add(Circle(
        circleId: CircleId(doc.id),
        center: location,
        radius: 50,
        strokeWidth: 2,
        strokeColor: circleColor,
        fillColor: circleColor.withOpacity(0.3),
      ));
    }

    return {"markers": newMarkers, "circles": newHeatCircles};
  }
}
