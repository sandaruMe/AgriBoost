
import 'package:cloud_firestore/cloud_firestore.dart';
class notification_service {
  final String? uid;

  notification_service({this.uid});


  final CollectionReference notCollection = FirebaseFirestore.instance
      .collection('Notifications');


  Future updateUserData(String? name,String notText,String dp) async {
    return await notCollection.doc(uid).set({
      'Name': name,
      'NotText':notText,
      'dp':dp

    });
  }
}