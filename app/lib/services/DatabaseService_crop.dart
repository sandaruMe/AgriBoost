
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService_crop {
  final String? docname;

  DatabaseService_crop({this.docname});


  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('Crop_mgmt');


  Future updateUserData(String postText,String heading ,String? post_Image) async {
    return await postCollection.doc(docname).set({

      'PostText':postText,
      'Heading':heading,
      'PostImage':post_Image,


    });
  }
}