import 'package:agri2/screens/Home/main_screen.dart';
import 'package:agri2/screens/splash/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyAccountPage extends StatefulWidget {
  final String uid;
  final String email;
  final String phoneNumber;

  VerifyAccountPage({required this.uid,required this.email, required this.phoneNumber});

  @override
  _VerifyAccountPageState createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {


  String _verificationMethod = 'Email';
  bool _otpRequested = false;
  String otp='';
  final TextEditingController _otpController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _loadUserProfile() async {

    await _firestore.collection('user_collection').doc(widget.uid).update({
      'acc_ver': '1',
    });

  }

  void _requestOtp() {
    setState(() {
      _otpRequested = true;
    });
    String maskedEmail = widget.email.replaceRange(2, widget.email.indexOf('@'), '*' * (widget.email.indexOf('@') - 2));
    String maskedPhoneNumber = widget.phoneNumber.replaceRange(3, widget.phoneNumber.length - 3, '*' * (widget.phoneNumber.length - 6));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('OTP Requested'),
        content: Text('OTP is sent to ${_verificationMethod == 'Email' ? maskedEmail : maskedPhoneNumber}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _verifyOtp() {
    // Add your OTP verification logic here
    if(otp=='1234') {
      _loadUserProfile();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP Verified Successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(uid: widget.uid,)),);
    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Faild to Verify OTP')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "AgriTech Security",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verify your account', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _verificationMethod,
              items: ['Email', 'Phone'].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _verificationMethod = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select verification method',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestOtp,
              child: Text('Request OTP'),
            ),
            if (_otpRequested) ...[
              SizedBox(height: 20),
              TextField(
                  controller: _otpController,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),

                  ),

                  onChanged: (val) {
                    setState(() {
                      otp = val;
                    });
                  }
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text('Verify OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
