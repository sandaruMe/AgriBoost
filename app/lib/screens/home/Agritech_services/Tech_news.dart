import 'package:flutter/material.dart';
import 'package:agri2/widgets/post_item.dart';
import 'package:agri2/util/data.dart';
import 'package:agri2/constants/colors.dart';

import 'package:agri2/constants/description.dart';
import 'package:agri2/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/Post_item_news.dart';
import 'News/Create_news_post.dart';

class TechNews extends StatefulWidget {
  @override


  @override
  _TechNewsState createState() => _TechNewsState();
}
class _TechNewsState extends State<TechNews> {
  @override
//Strem

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('News').snapshots();

// Get user data



  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
        title: Text(
          "News",
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
              return PostItemNews(
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
            MaterialPageRoute(builder: (context) => CreateNewsPostPage()),
          );
        },
      ),
    );
  }
}
