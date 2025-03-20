import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';

class Hospital {
  final String id;
  final String hname;
  final String address;
  final String phone;
  final String imageUrl;
  final double latitude;
  final double longitude;
  double? distance;

  Hospital({
    required this.id,
    required this.hname,
    required this.address,
    required this.phone,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  factory Hospital.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Hospital(
      id: doc.id,
      hname: data['hname'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
    );
  }
}

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Hospital> hospitals = [];
  List<Hospital> filteredHospitals = []; //  Added for search functionality
  bool isLoading = true;
  String? error;
  Position? userLocation;
  TextEditingController searchController =
      TextEditingController(); //  Search controller

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            error =
                "Location permission is required to fetch nearby hospitals.";
            isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await openAppSettings();
        setState(() {
          error =
              "Location permissions are permanently denied. Enable them from settings.";
          isLoading = false;
        });
        return;
      }

      Position userLocation = await Geolocator.getCurrentPosition();
      List<Hospital> fetchedHospitals =
          await _firebaseService.fetchHospitals(userLocation);

      setState(() {
        hospitals = fetchedHospitals;
        filteredHospitals = hospitals; //  Initially set filtered list
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching hospitals: ${e.toString()}");
      setState(() {
        error = "Error loading hospitals: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  //  Search Functionality
  void _filterHospitals(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredHospitals = hospitals;
      } else {
        filteredHospitals = hospitals
            .where((hospital) =>
                hospital.hname.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Header
          Container(
            height: double.infinity, // Adjusted for better transition
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1C16B9),
                  Color(0xff6D5FD5),
                  Color(0xff8A7FD6),
                ],
              ),
            ),
          ),

          // Back Button & Title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Nearby Hospitals",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.directions_car,
                        color: Colors.white, size: 28),
                    onPressed: () {
                      _makePhoneCall("1990");
                    },
                  ),
                ],
              ),
            ),
          ),

          // White Rounded Container for Content
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    // 🔹 Search Bar
                    TextField(
                      controller: searchController,
                      onChanged: _filterHospitals,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search hospitals...",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Spacing

                    // Hospital List
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredHospitals.length,
                        itemBuilder: (context, index) {
                          final hospital = filteredHospitals[index];
                          return _buildHospitalCard(context, hospital);
                        },
                      ),
                    ),
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  // Hospital Card Widget
  Widget _buildHospitalCard(BuildContext context, Hospital hospital) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            builder: (context) => _buildHospitalDetails(context, hospital),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                hospital.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Hospital Name (Expands while distance remains fixed)
                      Expanded(
                        child: Text(
                          hospital.hname,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Prevents text overflow
                          maxLines: 1, // Ensures it stays in a single line
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing
                      // Fixed Position Distance Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffB7AEF3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${hospital.distance?.toStringAsFixed(1)} km",
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Hospital Address
                  Text(
                    hospital.address,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalDetails(BuildContext context, Hospital hospital) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hospital.hname,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Address Row
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hospital.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Phone Number Button (Currently Non-Functional)
          GestureDetector(
              onTap: () => _makePhoneCall(hospital.phone),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffB7AEF3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.black45),
                    const SizedBox(width: 8),
                    Text(
                      hospital.phone,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // Function to Open Phone Dialer
  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
