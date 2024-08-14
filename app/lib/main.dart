import 'package:agri2/screens/Home/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:agri2/models/UserModel.dart';
import 'package:agri2/services/auth.dart';

import 'package:agri2/wrapper.dart';
import 'package:agri2/screens/splash/welcome.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAl3w1mXuYw913jBVtEHDEv4_nNIHw0PqA",
      appId: "1:925655656385:android:8f920c02aa8f9844d93140",
      messagingSenderId: "925655656385",
      projectId: "agri2-96f3a",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: welcome(),
      ),
    );
  }
}
