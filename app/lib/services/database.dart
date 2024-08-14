
import 'package:agri2/models/UserDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user_collection');

  Future updateUserData(String firstName ,String lastName,String email,String? country,String? state,String phone,String acc_ver,String?role)async{
    return await userCollection.doc(uid).set({
      'Firstname':firstName,
      'LastName':lastName,
      'Email':email,
      'Phone':phone,
      'Sountry':country,
      'State':state,
      'profileImageUrl':"",
      'acc_ver':acc_ver,
      'role':role
    });
  }
}