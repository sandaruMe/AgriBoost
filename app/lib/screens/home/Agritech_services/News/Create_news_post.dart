import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import '../../../../services/databace_notification.dart';
import '../../../../services/database_news.dart';



class CreateNewsPostPage extends StatefulWidget {


  @override
  _CreateNewsPostPageState createState() => _CreateNewsPostPageState();
}

class _CreateNewsPostPageState extends State<CreateNewsPostPage> {

  String logo ="https://firebasestorage.googleapis.com/v0/b/agri2-96f3a.appspot.com/o/profileImages%2FYimaMWbqBGTKOyXfR3IJjbNs3ug2.png?alt=media&token=5aceec70-9413-448f-8c90-bbf96d876821";
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'gs://agri2-96f3a.appspot.com');


  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  File? _imageFile;


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
          'News_images/'+'Agritech_news_${DateTime.now().millisecondsSinceEpoch}.jpg';
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

  Future<void> createPost(String postText, String heading ,String? imageUrl) async {
    String datetimenow = getCurrentDateTime();


    await DatabaseService_news(docname: 'News_Post_${datetimenow}')
        .updateUserData( postText, heading,imageUrl);

    await notification_service(uid: 'News_not_${datetimenow}')
        .updateUserData("Agri Tech SriLanka", "Added news Item",logo);
  }

  void _post(BuildContext context) async {
    final String postText = _textController2.text;
    final String headingText = _textController1.text;

    if (postText.isEmpty || headingText.isEmpty) {
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

    await createPost(postText, headingText,imageUrl);

    // Close the loading dialog and then navigate back
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    _textController1.clear();
    _textController2.clear();
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
                controller: _textController1,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Heading',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 0.5),

            Expanded(
              child: TextField(
                controller: _textController2,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'News',
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
