import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import '../../../services/databace_notification.dart';
import '../../../services/database_posts.dart';
import '../main_screen.dart';

class CreatePostPage extends StatefulWidget {
  final String uid;

  CreatePostPage({Key? key, required this.uid}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://agri2-96f3a.appspot.com');


  final TextEditingController _textController = TextEditingController();
  File? _imageFile;

  Future<List<String>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user_collection')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        String firstname = snapshot.get('Firstname') ?? '';
        String lastname = snapshot.get('LastName') ?? '';
        String dp = snapshot.get('profileImageUrl') ?? '';

        return [firstname + lastname, dp];
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateTimeFormatter.format(now);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String filePath =
          'post_images/'+'${widget.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = _storage.ref().child(filePath).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();


      print(downloadUrl);
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return null;
    }
  }

  Future<void> createPost(String postText, String? imageUrl) async {
    String datetimenow = getCurrentDateTime();
    List<String>? userData  = await getUserData(widget.uid);
    String name ='';
    String dp ='';
    if (userData != null && userData.length >= 2) {
         name = userData[0];
         dp = userData[1];
    }

      await DatabaseService_posts(uid: (widget.uid) + datetimenow)
        .updateUserData(name, postText, imageUrl,dp);

    await notification_service(uid: (widget.uid) + datetimenow)
        .updateUserData(name, "Added a post",dp);
  }

  void _post(BuildContext context) async {
    final String postText = _textController.text;

    if (postText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter some text')),
      );
      return;
    }

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

    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
    }

    await createPost(postText, imageUrl);

    // Close the loading dialog and then navigate back
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    _textController.clear();
    setState(() {
      _imageFile = null;
    });

    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            if (_imageFile != null)
              Image.file(_imageFile!,
                  height: 200, width: 200, fit: BoxFit.cover),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: () => _post(context),
                  child: Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
