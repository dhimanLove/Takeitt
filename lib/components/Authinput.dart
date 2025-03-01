import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeittt/components/snacbars.dart';
import 'package:takeittt/utils/type_def.dart';

import '../routes/routenames.dart';

class Authinput extends StatefulWidget {
  final String hintText, label;
  final ValidationCallback? validator;
  final bool isapasswordfield;
  final bool isconfirmpasswordfield;
  final TextEditingController controller;
  final Icon prefixIcon;

  const Authinput({

    this.isconfirmpasswordfield = false,
    required this.hintText,
    this.isapasswordfield = false,
    required this.label,
    required this.controller,
    super.key,
    required this.validator,
    required this.prefixIcon,
  });

  @override
  State<Authinput> createState() => _AuthinputState();
}

class _AuthinputState extends State<Authinput> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();



  registration()async{
    String userPassword = password.text;
    if(formkey.currentState!.validate()){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        SuccessSnackbar();
        Get.offAllNamed(
          Routenames.gnav,
          arguments: {
            'Name': name.text,
            'isAdmin': true,
            'password': userPassword,
          },
        );
      }
      on FirebaseAuthException catch(love){
        if (love.code == 'weak-password'){
          Get.snackbar('Error', 'The password provided is too weak.');
        }
        else if (love.code == 'email-already-in-use'){
          Get.snackbar(
            'Error',
            'The account already exists for that email.',
            snackPosition: SnackPosition.TOP,
            boxShadows: [BoxShadow(color: Color(0xFFE84E4E), blurRadius: 8)],
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            duration: Duration(seconds: 3),
            borderRadius: 20,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            overlayBlur: 4,
            icon: Icon(Icons.error, color: Colors.white, size: 30),
            shouldIconPulse: true,
          );
        }
      }
    }
  }


  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isapasswordfield || widget.isconfirmpasswordfield ?obscureText: false,
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: 1.5,
          wordSpacing: 1.5,
          decoration: TextDecoration.none,
          decorationColor: Colors.black,
          decorationThickness: 1.5,
        ),
        validator: widget.validator,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 3,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 6,
            ),
          ),
          hintText: widget.hintText,
          labelStyle: TextStyle(color: Colors.grey[900]),
          label: Text(widget.label),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isapasswordfield ||widget.isconfirmpasswordfield
              ? IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
