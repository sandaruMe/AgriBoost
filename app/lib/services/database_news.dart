
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService_news {
  final String? docname;

  DatabaseService_news({this.docname});


  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('News');


  Future updateUserData(String postText,String heading ,String? post_Image) async {
    return await postCollection.doc(docname).set({

      'PostText':postText,
      'Heading':heading,
      'PostImage':post_Image,


    });
  }
}