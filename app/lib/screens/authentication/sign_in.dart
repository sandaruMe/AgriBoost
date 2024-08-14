import 'package:flutter/material.dart';
import 'package:agri2/screens/splash/welcome.dart';
import 'package:agri2/constants/colors.dart';
import 'package:agri2/constants/description.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgwhite,
      appBar: AppBar(
        title: const Text("Sign In"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const welcome()),
            );
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
                  height: 150,
                ),
              ),
              const Center(
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 24.0, color: Colors.blueGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!_isLoading) ...[
                        // Email field
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(hintText: "Email"),
                          validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // Password field
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: textInputDecoration.copyWith(hintText: "Password"),
                          validator: (val) =>
                          val!.length < 6 ? "Password must be at least 6 characters" : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // Error message display
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 20),

                        // Google login
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

                        // Navigate to register page
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do not have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(color: mainBlue, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Login button
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              dynamic result = await _auth.signInUsingEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error = "Could not sign in with those credentials";
                                  _isLoading = false;
                                });
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Sign In Successful')),
                                );
                                // Optionally, navigate to another screen here
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: green2,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2, color: mainYellow),
                            ),
                            child: const Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ] else ...[
                        // Show progress indicator
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 20),
                        const Text("Signing in...",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
