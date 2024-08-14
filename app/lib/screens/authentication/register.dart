import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/description.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';
import '../../wrapper.dart'as wrapper;

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  bool _isLoading_reg = false; // Loading state
  final _formKey = GlobalKey<FormState>(); // Form key
  // Form data
  String fname = "";
  String lname = "";
  String? country = "";
  String? cstate = "";
  String email = "";
  String phone="";
  String password = "";
  String?user_type = "farmer";
  String error = "";
  String error_form = "";
  String? _selectedItem_country;
  String? _selectedItem_state;
  String? _selectedItem_user;

  // List of items for the dropdown
  final List<String> _dropdownItems_country = ['Sri Lanka', 'India', 'USA'];
  final Map<String, List<String>> _dropdownItems_states = {
    'Sri Lanka': ['Central', 'Eastern', 'Northern', 'Southern'],
    'India': ['Maharashtra', 'Karnataka', 'Tamil Nadu', 'Kerala'],
    'USA': ['California', 'Texas', 'Florida', 'New York'],
  };
  List<String> _dropdownItems_state = [];
  final List<String> _User_types_items = ['Admin', 'farmer', 'Investor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgwhite,
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'Menu Icon',
          onPressed: () {
            widget.toggle();
          },
        ),
        elevation: 0,
        backgroundColor: bgwhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!_isLoading_reg) ...[
                        // Input1 First name------------------------------------------------
                        TextFormField(
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                            hintText: "First Name",
                            labelText: "First Name",
                          ),
                          onChanged: (val) {
                            setState(() {
                              fname = val;
                            });
                          },
                          validator: (value) =>
                          value == "" ? 'Please Enter First name' : null,
                        ),
                        const SizedBox(height: 20),
                        // Input2 Last name------------------------------------------------
                        TextFormField(
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Last Name", labelText: "Last Name"),
                          onChanged: (val) {
                            setState(() {
                              lname = val;
                            });
                          },
                          validator: (value) =>
                          value == "" ? 'Please Enter Last name' : null,
                        ),
                        const SizedBox(height: 20),
                        // Input3 Country---------------------------------------------------
                        DropdownButtonFormField<String>(
                          decoration: textInputDecoration_dropdown.copyWith(
                            labelText: 'Country',
                            border: const OutlineInputBorder(),
                          ),
                          value: _selectedItem_country,
                          items: _dropdownItems_country.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(color: Colors.teal)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem_country = newValue;
                              _selectedItem_state = null; // Reset state selection
                              _dropdownItems_state =
                                  _dropdownItems_states[newValue!] ?? [];
                              country = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null ? 'Please select a country' : null,
                        ),
                        const SizedBox(height: 20),
                        // Input4 State---------------------------------------------------
                        DropdownButtonFormField<String>(
                          decoration: textInputDecoration_dropdown.copyWith(
                            labelText: 'State / Province',
                            border: const OutlineInputBorder(),
                          ),
                          value: _selectedItem_state,
                          items: _dropdownItems_state.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(color: Colors.teal)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem_state = newValue;
                              cstate = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null ? 'Please select a state' : null,
                        ),
                        const SizedBox(height: 20),
                        // Input5 Email----------------------------------------------------
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Email", labelText: "Email"),
                          validator: (val) =>
                          val!.isEmpty ? "Enter a valid email" : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Phone Number", labelText: "Phone Number"),
                          validator: (val) =>
                          val!.isEmpty ? "Enter a valid Phone Number" : null,
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Input6 Password-------------------------------------------------
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password", labelText: "Password"),
                          validator: (val) => val!.length < 6
                              ? "Password must be at least 6 characters"
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Input7 Confirm Password-----------------------------------------
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Confirm Password",
                              labelText: "Confirm Password"),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please confirm your password';
                            } else if (val != password) {
                              return 'Password confirmation failed';
                            }
                            return null; // Return null when the input is valid
                          },
                        ),
                        const SizedBox(height: 20),
                        // Input8 User type------------------------------------------------
                        DropdownButtonFormField<String>(
                          decoration: textInputDecoration_dropdown.copyWith(
                            labelText: 'User type',
                            border: const OutlineInputBorder(),
                          ),
                          value: _selectedItem_user,
                          items: _User_types_items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(color: Colors.teal)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem_user = newValue;
                              user_type = newValue;
                            });
                          },
                          validator: (value) =>
                          value == null ? 'Please select a user type' : null,
                        ),
                        const SizedBox(height: 20),
                        // Error message display-------------------------------------------
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 20),
                        // Social login section-------------------------------------------
                        const Text(
                          "Login with social accounts",
                          style: descriptionStyle,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Image.asset(
                              'assets/images/google.png',
                              height: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Navigate to login page------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do you have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: mainBlue, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Register button------------------------------------------------
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading_reg = true; // Show progress indicator
                              });

                              dynamic result;
                              if (user_type == 'Admin') {
                                if (email == 'agritechadmin1@gmail.com' ||
                                    email == 'agritechadmin2@gmail.com') {
                                  result = await _auth.registerWithEmailAndPassword(
                                      email,
                                      password,
                                      fname,
                                      lname,
                                      country,
                                      cstate,
                                      phone,
                                       '0',
                                      user_type
                                  );
                                  wrapper.acc_ver=='1';
                                  if (result == null) {
                                    // Error
                                    wrapper.acc_ver=='0';
                                    setState(() {
                                      error =
                                      "Please enter a valid email or password!";
                                      _isLoading_reg = false; // Hide progress indicator
                                    });
                                  }
                                } else {
                                  setState(() {
                                    error =
                                    "Cannot Register As Admin for current email";
                                    _isLoading_reg = false; // Hide progress indicator
                                  });
                                }
                              } else {
                                result = await _auth.registerWithEmailAndPassword(
                                    email,
                                    password,
                                    fname,
                                    lname,
                                    country,
                                    cstate,
                                    phone,
                                    '0',
                                    user_type

                                );

                                wrapper.acc_ver=='1';
                                if (result == null) {
                                  // Error
                                  wrapper.acc_ver=='0';
                                  setState(() {
                                    error =
                                    "Please enter a valid email or password!";
                                    _isLoading_reg = false; // Hide progress indicator
                                  });
                                } else {
                                  setState(() {
                                    _isLoading_reg = false; // Hide progress indicator
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Registration Successful')),
                                  );
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: bgBlack,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 2, color: mainYellow)),
                            child: const Center(
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ] else ...[
                        // Show progress indicator
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 20),
                        const Text("Registering...",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ],
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
