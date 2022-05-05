import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth=FirebaseAuth.instance;


  User? _userFromFirebaseUser(User? user){
     return user;
  }
  Stream<User?> get user{
    return _auth.authStateChanges();
  }
  Future signInAnonymous()async{
    try{
    UserCredential _result= await _auth.signInAnonymously();
    User? user=_result.user;
    return user;
    }
        catch(e){
  debugPrint(e.toString());
  return null;
        }
  }
  Future signIn({required String email, required String password}) async {
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = _result.user;
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }}
  Future<bool> signOut()async{
    try{
      await _auth.signOut();
      return true;
    }
    catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
  Future registerEmailAndPass({required String email,required String pass})async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    User? user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      debugPrint(e.toString());
      return null;
    }
  }
}