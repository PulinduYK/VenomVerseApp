import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'SuccessPage.dart';

class BirthdayGenderPage extends StatefulWidget {
  @override
  _BirthdayGenderPageState createState() => _BirthdayGenderPageState();
}

class _BirthdayGenderPageState extends State<BirthdayGenderPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime(2000, 1, 1); // Default Date
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

  bool _isFormValid() {
    return _nameController.text.isNotEmpty;
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
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
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
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // User Name Field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Modern Birthday Picker
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MMMM d, yyyy').format(_selectedDate),
                              style: TextStyle(fontSize: 18, color: Colors.black54),
                            ),
                            Icon(Icons.calendar_today, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Gender Selection
                    const Text(
                      "Select Gender",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Male Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'Male';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'Male'
                                  ? Color(0xFF6D5FD5)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.male,
                                  color: _selectedGender == 'Male' ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedGender == 'Male' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Female Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'Female';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'Female'
                                  ? Color(0xFF6D5FD5)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.female,
                                  color: _selectedGender == 'Female' ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedGender == 'Female' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: _isFormValid()
                            ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessPage(),
                            ),
                          );
                        }
                            : null,
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: _isFormValid()
                                ? const LinearGradient(
                              colors: [
                                Color(0xFF1C16B9),
                                Color(0xFF6D5FD5),
                                Color(0xFF8A7FD6),
                              ],
                            )
                                : null,
                            borderRadius: BorderRadius.circular(30),
                            color: _isFormValid() ? null : Colors.grey,
                          ),
                          child: const Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
