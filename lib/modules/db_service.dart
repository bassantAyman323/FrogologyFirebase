import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduationproj1/modules/users.dart';

class DBServices{
  var userCollection=FirebaseFirestore.instance.collection('users');

  saveUser(CUser user)async{
    try{
      await userCollection.doc(user.uid).set(user.toJson());
    }catch(e){}
  }
}