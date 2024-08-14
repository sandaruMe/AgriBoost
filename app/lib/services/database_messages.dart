
import 'package:agri2/models/UserDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService_mesaage{
  final String? Doc_name;





  DatabaseService_mesaage({required this.Doc_name});


  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Messages');


  Future updateUserData(String name,String dp ,String status)async{
    return await userCollection.doc(Doc_name).set({
      'Name':name,
      'dp':dp,
      'Status':status,
    });


  }



}