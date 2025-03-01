import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/components/Authinput.dart';
import 'package:takeittt/components/continuegoogle.dart';
import 'package:takeittt/components/snacbars.dart';
import 'package:takeittt/routes/routenames.dart';
import 'package:takeittt/utils/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  final Registercontroller userController = Get.find();
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Registercontroller userController = Get.put(Registercontroller());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool valuee = false;

  registration() async {
    String userPassword = password.text;
    if (formkey.currentState!.validate() && valuee == true) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        // Store user data in Firestore using the Firebase UID (no image data)
        Map<String, dynamic> userinfomap = {
          'Name': name.text,
          'email': email.text,
          'password': userPassword,
        };

        await _firestore.collection('User').doc(userCredential.user!.uid).set(userinfomap);

        SuccessSnackbar();
        Get.toNamed(
          Routenames.gnav,
          arguments: {
            'Name': name.text,
            'isAdmin': true,
            'password': userPassword,
          },
        );
      } on FirebaseAuthException catch (love) {
        if (love.code == 'weak-password') {
          Get.snackbar('Error', 'The password provided is too weak.');
        } else if (love.code == 'email-already-in-use') {
          // Handle existing user: Try to sign in or update their Firestore data
          try {
            UserCredential existingUserCredential = await _auth.signInWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );

            // Update or verify Firestore data for the existing user
            DocumentSnapshot doc = await _firestore.collection('User').doc(existingUserCredential.user!.uid).get();
            if (!doc.exists) {
              Map<String, dynamic> userinfomap = {
                'Name': name.text,
                'email': email.text,
                'password': userPassword,
              };
              await _firestore.collection('User').doc(existingUserCredential.user!.uid).set(userinfomap);
            } else {
              // Optionally update only changed fields (e.g., Name, password)
              Map<String, dynamic> updates = {};
              if (name.text.isNotEmpty && name.text != doc['Name']) updates['Name'] = name.text;
              if (userPassword.isNotEmpty && userPassword != doc['password']) updates['password'] = userPassword;

              if (updates.isNotEmpty) {
                await _firestore.collection('User').doc(existingUserCredential.user!.uid).update(updates);
              }
            }

            SuccessSnackbar();
            Get.toNamed(
              Routenames.gnav,
              arguments: {
                'Name': name.text,
                'isAdmin': true,
                'password': userPassword,
              },
            );
          } catch (e) {
            Get.snackbar('Error', 'Invalid password or account issue: $e',
                snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
          }
        }
      }
    }
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      String userPassword = password.text;

      // Clear inputs
      email.clear();
      password.clear();
      confirmpassword.clear();
      name.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Container(
                            height: Get.height * 0.2,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Create Your Account',
                                        style: TextStyle(
                                          height: 0.9,
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Hero(
                                            tag: 'ran',
                                            child: Text(
                                              'And',
                                              style: GoogleFonts.inter(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orangeAccent,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Hero(
                                            tag: 'ter',
                                            child: Text(
                                              'TakeIt',
                                              style: GoogleFonts.inter(
                                                fontSize: 40,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 13,
                            top: -5,
                            child: Image.network(
                              'https://s3-alpha-sig.figma.com/img/1f18/cb2b/2d5474c3df4060657a67836c1fc15d30?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DtMfTJqnDzrjuhdsotXfrlGCgkEmRDRlgaipxuBZNLr1MZ7rF3D9372Oo3eHuXjYovZfaoBnPIQkP41yL8sN38-6biloWIMBMJaJBhwYR9RuAPqtiR~gmhSu6Cstn-a0SsuwRf0ES3C9bj09oHBdO14eklgg6LOnnlsIiT4AXDMl4pydLAVN2FKOjOM7k0kCl6bwbvRtT~pLaCmI-xFX5p6mcw4NdeYAofv4YEnkyK0v0aAGtoUemskk6s9IrVKTy2KXKlqsRGZbuenD78XAp1PNFM~0Ss7z0SSyu8znWHRGeZnVpSSYNniEj8As4vm3kgv7OPPo8Wja4SMyU~YXrA__',
                              fit: BoxFit.fill,
                              height: Get.height * 0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Authinput(
                      validator: ValidationBuilder()
                          .required()
                          .minLength(3)
                          .maxLength(20)
                          .build(),
                      controller: name,
                      hintText: 'Enter Name',
                      label: 'Username',
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        size: 19,
                      ),
                    ),
                    SizedBox(height: 10),
                    Authinput(
                      validator: ValidationBuilder().required().email().build(),
                      controller: email,
                      hintText: 'Enter Email',
                      label: 'Email',
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Authinput(
                      validator: ValidationBuilder()
                          .required()
                          .minLength(6)
                          .maxLength(10)
                          .regExp(
                        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,10}$'),
                        "Password must have 1 A-Z, 1 a-z, 1 number, & 1 special char",
                      )
                          .build(),
                      controller: password,
                      hintText: 'Enter Password',
                      label: 'Password',
                      isapasswordfield: true,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Authinput(
                      validator: (value) {
                        if (value != password.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      controller: confirmpassword,
                      hintText: 'Confirm Password',
                      label: 'Confirm Password',
                      isapasswordfield: true,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.orange,
                            value: valuee,
                            onChanged: (bool? newValue) {
                              setState(() {
                                valuee = newValue!;
                              });
                            },
                          ),
                          Text(
                            'I agree to the terms and conditions',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: registration, // Simplified to call registration directly
                      child: Hero(
                        tag: 'Button',
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: Get.height * 0.043,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'or',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                    Hero(
                      tag: 'google',
                      child: Googlecont(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            child: Hero(
                              tag: 'randing',
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(Routenames.login);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}