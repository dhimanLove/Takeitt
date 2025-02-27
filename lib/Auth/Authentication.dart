import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlesignin{
  final FirebaseAuth auth = FirebaseAuth.instance;


  getcurrentuser()async{
    return await auth.currentUser;

  }
  signInWithGoogle(
      BuildContext context
      )
  async
  {
      final FirebaseAuth firebaseAuth  = FirebaseAuth.instance ;
      final GoogleSignIn googleSignIn =GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
  }
}