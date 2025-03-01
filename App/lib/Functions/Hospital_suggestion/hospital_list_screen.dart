import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HospitalListScreen extends StatelessWidget {
  final List<Map<String, String>> hospitals = [
    {
      'name': 'City General Hospital',
      'address': '123 Healthcare Ave, City Center',
      'phone': '+1234567890',
      'distance': '2.5 km',
      'image': 'https://images.unsplash.com/photo-1587351021759-3e566b6af7cc?q=80&w=2940&auto=format&fit=crop'
    },
    {
      'name': 'Emergency Care Center',
      'address': '456 Medical Blvd, Downtown',
      'phone': '+1234567891',
      'distance': '3.8 km',
      'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2940&auto=format&fit=crop'
    },
    {
      'name': 'Emergency Care Center',
      'address': '456 Medical Blvd, Downtown',
      'phone': '+1234567891',
      'distance': '3.8 km',
      'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2940&auto=format&fit=crop'
    },
    {
      'name': 'Emergency Care Center',
      'address': '456 Medical Blvd, Downtown',
      'phone': '+1234567891',
      'distance': '3.8 km',
      'image': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2940&auto=format&fit=crop'
    },
  ];

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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Back Button & Title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
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
                ],
              ),
            ),
          ),

          // White Rounded Container for Content
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 170,
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
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: hospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = hospitals[index];
                    return _buildHospitalCard(context, hospital);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hospital Card Widget
  Widget _buildHospitalCard(BuildContext context, Map<String, String> hospital) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Open bottom sheet when clicking a hospital
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                hospital['image']!,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hospital['name']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          hospital['distance']!,
                          style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    hospital['address']!,
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

  // Bottom Sheet for Hospital Details
  Widget _buildHospitalDetails(BuildContext context, Map<String, String> hospital) {
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
          // Hospital Name
          Text(
            hospital['name']!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Address Row
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hospital['address']!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Phone Number Button (Currently Non-Functional)
          GestureDetector(
              onTap: () => _makePhoneCall(hospital['phone']!),
              child:Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Text(
                      hospital['phone']!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
          ),
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
