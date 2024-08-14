import 'package:flutter/material.dart';
import 'package:agri2/widgets/post_item.dart';
import 'package:agri2/util/data.dart';
import 'package:agri2/constants/colors.dart';

import 'package:agri2/constants/description.dart';
import 'package:agri2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/Post_item_crop.dart';
import '../../../widgets/Post_item_soil.dart';
import 'Crop/CreatePostCrop.dart';
import 'Soil/Create_soil_posts.dart';


class crop_mgmt extends StatefulWidget {
  @override


  @override
  _crop_mgmtState createState() => _crop_mgmtState();
}
class _crop_mgmtState extends State<crop_mgmt> {
  @override
//Strem

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Crop_mgmt').snapshots();

// Get user data



  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Crop Managements",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return PostItemCrop(
                img: data['PostImage'],
                time: posts[0]['time'],
                postdata: data['PostText'],
                title: data['Heading'],
              );

              /*ListTile(
                title: Text(data['Name']),
                subtitle: Text(data['PostText']),
              );*/
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatecroplPostPage()),
          );
        },
      ),
    );
  }
}
