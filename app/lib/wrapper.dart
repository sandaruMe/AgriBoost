

import 'package:agri2/screens/Home/main_screen.dart';
import 'package:agri2/services/accout_verification.dart';


import 'package:flutter/material.dart';
import 'package:agri2/models/UserModel.dart';
import 'package:agri2/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String acc_ver = '0';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}



class _WrapperState extends State<Wrapper> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String acc_ver = '0';
  String phone='';
  String email='';

  Future<void> _loadUserProfile(String uid) async {
    DocumentSnapshot userDoc =
    await _firestore.collection('user_collection').doc(uid).get();
    setState(() {
      acc_ver = userDoc['acc_ver'];
      phone   =  userDoc['Phone'];
      email   =  userDoc['Email'];
    });
  }


  @override
  Widget build(BuildContext context) {
    //the user data that the provider proides this can be a user data or can be null.
    final user = Provider.of<UserModel?>(context);


    if (user == null) {
      return Authenticate();
    } else {
      _loadUserProfile(user.uid);
      if (acc_ver == '0') {

        return VerifyAccountPage(uid:user.uid,email:  email,phoneNumber: phone,);

      }
      else {
        return MainScreen(uid: user.uid);
      }
    }
  }
}





