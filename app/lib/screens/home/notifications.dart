import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class notifications_get extends StatefulWidget {
  @override
  _notifications_get createState() => _notifications_get();
}

class _notifications_get extends State<notifications_get> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _userProfiles = [];
  bool _isLoading = true;

  final List<String> _items = List<String>.generate(10, (i) => 'User ${i + 1}');
  // List to track follow status for each item
  late List<bool> _isFollowing;

  void _toggleFollow(int index) {
    setState(() {
      _isFollowing[index] = !_isFollowing[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _isFollowing = List<bool>.filled(_items.length, false);
    _loadUserProfiles();
  }

  Future<void> _loadUserProfiles() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('Notifications').get();
    List<Map<String, dynamic>> userDataList = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    setState(() {
      _userProfiles = userDataList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        padding: EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Divider(),
            ),
          );
        },
        itemCount: _userProfiles.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> user = _userProfiles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['dp'] ?? ''),
                radius: 25,
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: user['Name'] ?? 'No Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " is " + (user['NotText'] ?? 'No Name'),
                    ),
                  ],
                ),
              ),
              subtitle: Text(user['status'] ?? 'No Status'),
              trailing: Text("Time now"),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
