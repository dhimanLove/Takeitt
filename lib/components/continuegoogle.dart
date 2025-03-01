import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takeittt/Auth/Authentication.dart';
import 'package:takeittt/routes/routenames.dart';

class Googlecont extends StatefulWidget {
  const Googlecont({super.key});

  @override
  State<Googlecont> createState() => _GooglecontState();
}

class _GooglecontState extends State<Googlecont> {

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In canceled by user')),
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Map<String, dynamic> userData = {
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
          'profilePic': userCredential.user!.photoURL,
          'uid': userCredential.user!.uid,
        };

        try {
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(
            userData,
            SetOptions(merge: true),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data saved successfully')),
          );

          Navigator.pushReplacementNamed(context, '/home');
        } catch (e) {
          print("Error saving user data to Firestore: $e");
          if (e is FirebaseException) {
            print("Firebase error code: ${e.code}");
            print("Firebase error message: ${e.message}");
          } else if (e is PlatformException) {
            print("Platform exception: ${e.code}");
            print("Platform exception message: ${e.message}");
          } else {
            print("Unexpected error: $e");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save user data to Firestore')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to retrieve user details')),
        );
      }

      print("Signed in as: ${userCredential.user?.email}");
    } catch (e) {
      print("Error signing in with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        loginWithGoogle(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 35,
        ),
        height: Get.height*0.05,
        width: MediaQuery.of(context).size.width * 2,
        decoration: BoxDecoration(
          //color: Colors.orange,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:25
          ),
          child: Row(
            children: [
              Image.network(
                'https://s3-alpha-sig.figma.com/img/9690/3368/9b71a1845255c9f583f1866f305d4aec?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qSoDog1bZhYI62gj6qto4VuWr75rwgv~p2cvqbNEayOhkl0f1~mS76vD4Hqok1bndTp85LYbjuA85uxRKA2Z6tlga-zTsB8qThtNthIsy2WWudgs~nZGOgm07cw7TtCfwZ1rw06FyUcnWYdDr7OihL2v2LzHX58MgDaKVWBkrG~UtA72SWZgYjzlkh9xy6sMZ6ORs9Oto54FP~EKslO5X2StE0xW72zaxmOaCNWK6bC-l7S3V2FpAe~qFgsRMTfFZKtR9Ox2seD6NGFrpLJDyWRsykxS4lmqgpRchCZGcscdo5IVTdlL059N~1WFuSh1JbBhVEr8TY3BjGtZHJqQkw__',
                height: Get.height*0.027,
              ),
              SizedBox(width: 10),
              Text(
                'Continue with Google',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
