import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Login_and_signup_logic/services/firebase.dart';
import '../../done/SuccessPage.dart';

class BirthdayGenderPage extends StatefulWidget {
  const BirthdayGenderPage({super.key});

  @override
  _BirthdayGenderPageState createState() => _BirthdayGenderPageState();
}

class _BirthdayGenderPageState extends State<BirthdayGenderPage> {
  final TextEditingController _fullNameController = TextEditingController();
  DateTime _selectedDate = DateTime(2024, 12, 25);
  String _selectedGender = 'Male';

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF6D5FD5),
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6D5FD5),
              secondary: Color(0xFF1C16B9),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF1C16B9),
              Color(0xFF6D5FD5),
              Color(0xFF8A7FD6),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Complete Your Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Full Name Input Field (No Border)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.black54),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _fullNameController,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Full Name",
                                border: InputBorder.none, // Hides the border
                                hintStyle: TextStyle(color: Colors.black54),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Modern Birthday Picker
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MMMM d, yyyy').format(_selectedDate),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            Icon(Icons.calendar_today, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Modern Gender Selection
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Male';
                              });
                            },
                            child: Chip(
                              label: Text('Male'),
                              backgroundColor: _selectedGender == 'Male'
                                  ? Color(0xFF6D5FD5)
                                  : Colors.grey[300],
                              labelStyle: TextStyle(
                                color: _selectedGender == 'Male'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGender = 'Female';
                              });
                            },
                            child: Chip(
                              label: Text('Female'),
                              backgroundColor: _selectedGender == 'Female'
                                  ? Color(0xFF6D5FD5)
                                  : Colors.grey[300],
                              labelStyle: TextStyle(
                                color: _selectedGender == 'Female'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () async {
                          String fullName = _fullNameController.text.trim();
                          if (fullName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter your full name"),
                                backgroundColor: Colors.white10,
                              ),
                            );
                            return;
                          }
                          await FirebaseService().updateFirst(
                              _fullNameController.text,
                              _selectedDate.toString(),
                              _selectedGender);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessPage(),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1C16B9),
                                Color(0xFF6D5FD5),
                                Color(0xFF8A7FD6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
