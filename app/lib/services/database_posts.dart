
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService_posts {
  final String? uid;

  DatabaseService_posts({this.uid});


  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('Posts');


  Future updateUserData(String? name,String postText,String? post_Image,String dp) async {
    return await postCollection.doc(uid).set({
      'Name': name,
      'PostText':postText,
      'PostImage':post_Image,
      'dp':dp

    });
  }
}