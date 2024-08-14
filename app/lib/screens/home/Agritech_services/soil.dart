import 'package:flutter/material.dart';
import 'package:agri2/widgets/post_item.dart';
import 'package:agri2/util/data.dart';
import 'package:agri2/constants/colors.dart';

import 'package:agri2/constants/description.dart';
import 'package:agri2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/Post_item_soil.dart';
import 'Soil/Create_soil_posts.dart';


class Soil_mgmt extends StatefulWidget {
  @override


  @override
  _Soil_mgmtState createState() => _Soil_mgmtState();
}
class _Soil_mgmtState extends State<Soil_mgmt> {
  @override
//Strem

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Soil_mgmt').snapshots();

// Get user data



  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Soil Managements",
          style: TextStyle(
            fontSize: 20.0,
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
              return PostItemSoil(
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
            MaterialPageRoute(builder: (context) => CreateSoilPostPage()),
          );
        },
      ),
    );
  }
}
