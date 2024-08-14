import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  final String uid;

  UserProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'gs://agri2-96f3a.appspot.com');
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? country;
  String? state;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    DocumentSnapshot userDoc =
    await _firestore.collection('user_collection').doc(widget.uid).get();
    setState(() {
      profileImageUrl = userDoc['profileImageUrl'];
      firstName = userDoc['Firstname'];
      lastName = userDoc['LastName'];
      country = userDoc['Sountry'];
      state = userDoc['State'];

      // Initialize text controllers with current values
      _firstNameController.text = firstName ?? '';
      _lastNameController.text = lastName ?? '';
      _countryController.text = country ?? '';
      _stateController.text = state ?? '';
    });
  }

  Future<void> _updateUserProfile() async {


    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text('Creating post...'),
              ],
            ),
          ),
        );
      },
    );
    // Upload new profile image if selected
    if (_newProfileImage != null) {
      await _uploadImage(_newProfileImage!);
    }

    // Update user details in Firestore
    await _firestore.collection('user_collection').doc(widget.uid).update({
      'Firstname': _firstNameController.text,
      'LastName': _lastNameController.text,
      'Sountry': _countryController.text,
      'State': _stateController.text,
      // Update profile image URL only if it's changed
      if (_newProfileImage != null) 'profileImageUrl': profileImageUrl,
    });

    // Update local state with new values
    setState(() {
      firstName = _firstNameController.text;
      lastName = _lastNameController.text;
      country = _countryController.text;
      state = _stateController.text;
    });

    // Close the loading dialog and then navigate back
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  File? _newProfileImage;

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newProfileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(File file) async {
    String filePath = 'profileImages/' + widget.uid + '.png';
    UploadTask uploadTask = _storage.ref().child(filePath).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      profileImageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "User Profile",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImageUrl != null
                ? CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl!),
            )
                : CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Profile Picture'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            TextField(
              controller: _stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: Text('Update User Details'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
