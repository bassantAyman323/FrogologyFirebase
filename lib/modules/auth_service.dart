import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduationproj1/modules/db_service.dart';
import 'package:graduationproj1/modules/users.dart';

class AuthServices{
  final _auth=FirebaseAuth.instance;

  Future<bool> signIn(String email,String password)async{
    try{
     await _auth.signInWithEmailAndPassword(email: email, password: password);
     return true;

    }on FirebaseException catch (e){
      return false;

    }
  }
  signUp(String name,String email,String password)async{
    try{
    _auth.createUserWithEmailAndPassword(email: email, password: password);
    await DBServices().saveUser(CUser(uid: user.uid,email: user.email,name: name));
    return true;
  }on FirebaseException catch(e){
      return false;
    }

}
User get user=> FirebaseAuth.instance.currentUser;

  signOut()async{
    try{
      await _auth.signOut();
    }catch(e){

    }
  }
}