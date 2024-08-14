
import 'package:agri2/screens/home/Market/create_market_post.dart';
import 'package:agri2/widgets/post_item_market.dart';
import 'package:flutter/material.dart';
import 'package:agri2/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Market_place extends StatefulWidget {
  @override
  String uid;
  Market_place({Key? key, required this.uid}) : super(key: key);

  @override
  _Market_placeState createState() => _Market_placeState();
}
class _Market_placeState extends State<Market_place> {
  @override
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String user_role="";


  Future<void> _loadUserProfile() async {
    DocumentSnapshot userDoc =
    await _firestore.collection('user_collection').doc(widget.uid).get();
    setState(() {
      user_role = userDoc['role'];

    });
  }

  void initState() {
    super.initState();
    _loadUserProfile();
  }
  //Strem
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Market').snapshots();

// Get user data

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Market Place",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),


      ),
      backgroundColor: Colors.grey,
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
              return PostItem_market(
                  img: data['PostImage'],
                  name: data['Name'],
                  dp: data['dp'],
                  time: posts[0]['time'],
                  postdata: data['PostText'],
                  role:this.user_role
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
            MaterialPageRoute(builder: (context) => CreateMarketPostPage(uid: widget.uid,)),
          );
        },
      ),
    );
  }
}
