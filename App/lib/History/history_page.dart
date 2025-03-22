import 'package:flutter/material.dart';

import '../Login_and_signup/Login_and_signup_logic/services/firebase.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final FirebaseService _firebaseService = FirebaseService();

  void _clearHistory() async {
    await _firebaseService.clearHistory();
  }

  void _deleteHistory(String historyId) async {
    await _firebaseService.deleteHistory(historyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1C16B9),
              Color(0xFF6D5FD5),
              Color(0xFF8A7FD6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_sweep,
                            size: 40, color: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Clear All History?"),
                              content:
                                  const Text("This action cannot be undone."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _clearHistory();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Clear",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.00),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 29.0),
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _firebaseService.getHistoryStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Loading indicator
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("Error loading history"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("No history available"));
                        }

                        List<Map<String, dynamic>> history = snapshot.data!;

                        return NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll
                                .disallowIndicator(); // Hides overscroll glow effect
                            return true;
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              final item = history[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    child: Icon(Icons.history,
                                        color: Colors.white),
                                  ),
                                  title: Text(
                                    item['UserPreferredType'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        "Status: ${item['status']}",
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "Preview: ${item['previewStatus']}",
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "Name: ${item['detectedName']}",
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "Time: ${item['timestamp']}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteHistory(item['id']),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
