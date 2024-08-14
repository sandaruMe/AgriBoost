
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService_soil {
  final String? docname;

  DatabaseService_soil({this.docname});


  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('Soil_mgmt');


  Future updateUserData(String postText,String heading ,String? post_Image) async {
    return await postCollection.doc(docname).set({

      'PostText':postText,
      'Heading':heading,
      'PostImage':post_Image,


    });
  }
}