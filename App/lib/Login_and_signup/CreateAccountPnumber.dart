import 'package:flutter/material.dart';
import 'VerifyP.dart'; // Import the verification page

class CreateAccountPnumber extends StatefulWidget {
  const CreateAccountPnumber({super.key});

  @override
  State<CreateAccountPnumber> createState() => _CreateAccountPnumberState();
}

class _CreateAccountPnumberState extends State<CreateAccountPnumber> {
  final TextEditingController _phoneController = TextEditingController();

  String _selectedCountryName = 'Sri Lanka';
  String _selectedCountryCode = '+94';
  bool _isPhoneValid = true;

  // Valid phone number prefixes for Sri Lanka
  final List<String> _validSLPrefixes = ['72', '75', '77', '78', '70', '76'];

  // Show country picker
  void _showCountryPicker() {
    final List<Map<String, String>> countries = [
      {'name': 'Sri Lanka', 'code': '+94'},
      {'name': 'United States', 'code': '+1'},
      {'name': 'United Kingdom', 'code': '+44'},
      {'name': 'India', 'code': '+91'},
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: countries.map((country) {
            return ListTile(
              title: Text('${country['name']} (${country['code']})'),
              onTap: () {
                setState(() {
                  _selectedCountryName = country['name']!;
                  _selectedCountryCode = country['code']!;
                  _phoneController.clear(); // Clear input when country changes
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  // Validate phone number for Sri Lanka or general case based on country selection
  bool _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return false;

    // Validation for Sri Lanka
    if (_selectedCountryCode == '+94') {
      if (phoneNumber.length == 9) {
        String prefix = phoneNumber.substring(0, 2); // First two digits
        return _validSLPrefixes.contains(prefix);
      }
      return false;
    }

    // General validation for other countries
    return phoneNumber.length >= 9 && phoneNumber.length <= 15 && RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
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
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
                      'Phone Number Verification',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Country Picker
                    GestureDetector(
                      onTap: _showCountryPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$_selectedCountryName ($_selectedCountryCode)'),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Phone Number Input Field
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixText: '$_selectedCountryCode ',
                        hintText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorText: !_isPhoneValid && _phoneController.text.isNotEmpty
                            ? 'Invalid phone number'
                            : null,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          _isPhoneValid = _validatePhoneNumber(value);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Send OTP Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(0),
                          elevation: 0,
                          backgroundColor:
                          _isPhoneValid ? const Color(0xFF1C16B9) : Colors.grey,
                        ),
                        onPressed: _isPhoneValid
                            ? () {
                          // Navigate to VerifyPage with the selected phone number
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyPage(
                                phoneNumber: '$_selectedCountryCode${_phoneController.text}', email: '',
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('OTP sent to your phone'),
                            ),
                          );
                        }
                            : null,
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: _isPhoneValid
                                ? const LinearGradient(
                              colors: [
                                Color(0xFF1C16B9),
                                Color(0xFF6D5FD5),
                                Color(0xFF8A7FD6),
                              ],
                            )
                                : const LinearGradient(
                              colors: [Colors.grey, Colors.grey],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Send OTP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
