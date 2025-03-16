import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../widgets/profile_page_template.dart';

class TeamMember {
  final String name;
  final String role;
  final String description;
  final String github;
  final String linkedin;

  TeamMember({
    required this.name,
    required this.role,
    required this.description,
    required this.github,
    required this.linkedin,
  });

  // Function to fetch GitHub profile image URL using the GitHub API
  Future<String?> fetchGitHubProfileImage() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.github.com/users/$github'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['avatar_url']; // GitHub profile image URL
      } else {
        throw 'Failed to load GitHub profile image. Status code: ${response.statusCode}';
      }
    } catch (e) {
      print("Error fetching GitHub profile image: $e");
      return null; // Return null if there's an error
    }
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  // Function to open URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TeamMember> teamMembers = [
      TeamMember(
        name: "Pulindu Kulathilaka",
        role: "Software Engineer Undergraduate",
        description: "Leads the company with strategic vision.",
        github: "PulinduYK", // GitHub username
        linkedin: "https://www.linkedin.com/in/pulindu-k-686a5a293",
      ),
      TeamMember(
        name: "Dewmi Wenushika",
        role: "Software Engineer Undergraduate",
        description: "Oversees technology and innovation.",
        github: "Dewmiiii", // GitHub username
        linkedin: "https://www.linkedin.com/in/dewmi-wenushika-0367a7297",
      ),
      TeamMember(
        name: "Thevindu Guruge",
        role: "Software Engineer Undergraduate",
        description: "Manages development and coding standards.",
        github: "gurugetnm", // GitHub username
        linkedin: "https://linkedin.com/in/thevindu-guruge",
      ),
      TeamMember(
        name: "Nipun Karunarathna",
        role: "Software Engineer Undergraduate",
        description: "Manages development and coding standards.",
        github: "NipunChamodya", // GitHub username
        linkedin: "https://www.linkedin.com/in/nipun-karunarathna2002",
      ),
      TeamMember(
        name: "Prabhashan Madurawala",
        role: "Software Engineer Undergraduate",
        description: "Manages development and coding standards.",
        github: "Prabhashan19", // GitHub username
        linkedin: "https://www.linkedin.com/in/prabhashan-madurawala",
      ),
    ];

    return ProfilePageTemplate(
      title: "About Us",
      contentHeightFactor: 0.85,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            return FutureBuilder<String?>(
              future: teamMembers[index].fetchGitHubProfileImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child:
                                CircularProgressIndicator(), // Show loading indicator while fetching image
                          ),
                          const SizedBox(height: 12),
                          Text(
                            teamMembers[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            teamMembers[index].role,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamMembers[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons
                                .error), // Show error icon when fetching fails
                          ),
                          const SizedBox(height: 12),
                          Text(
                            teamMembers[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            teamMembers[index].role,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamMembers[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.data == null) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            teamMembers[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            teamMembers[index].role,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamMembers[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset("assets/github_icon.png",
                                    width: 30),
                                onPressed: () =>
                                    _launchURL(teamMembers[index].github),
                              ),
                              const SizedBox(width: 15),
                              IconButton(
                                icon: Image.asset("assets/linkedin_icon.png",
                                    width: 30),
                                onPressed: () =>
                                    _launchURL(teamMembers[index].linkedin),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(snapshot.data!),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            teamMembers[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            teamMembers[index].role,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamMembers[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset("assets/github_icon.png",
                                    width: 30),
                                onPressed: () =>
                                    _launchURL(teamMembers[index].github),
                              ),
                              const SizedBox(width: 15),
                              IconButton(
                                icon: Image.asset("assets/linkedin_icon.png",
                                    width: 30),
                                onPressed: () =>
                                    _launchURL(teamMembers[index].linkedin),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
