
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/routes/routenames.dart';
import '../components/Authinput.dart';
import '../components/continuegoogle.dart';
import '../components/snacbars.dart';
import '../utils/user_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
final Logincontroler logincontroler = Get.put(
  Logincontroler()
);

class _LoginState extends State<Login> {

  Future<void> userlogin() async {
    String userPassword = password.text;

    if (formkey.currentState!.validate()) {
      try {
        print("Attempting login with email: ${email.text}");
        print(email.text);
        print(password.text);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        print("user credential gathered");
        Get.toNamed(
          Routenames.gnav,
          arguments: {
            'Email': email.text,
            'isAdmin': true,
            'password': userPassword,
          },
        );

      } on FirebaseAuthException catch (error) {
        print("Firebase Auth Error: ${error.code}");
        if (error.code == 'user-not-found') {
          Get.snackbar('Error', 'No user found for that email.');
        } else if (error.code == 'wrong-password') {
          Get.snackbar(
            'Error',
            'Incorrect password for that email.',
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
        } else if (error.code == 'requires-recent-login') {
          // Handle token expiry or session invalidation
          Get.snackbar(
            'Session Expired',
            'Your session has expired. Please log in again.',
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
        } else {
          // Handle other Firebase exceptions
          Get.snackbar('Error', 'Authentication error: ${error.message}');
        }
      } catch (e) {
        // Catch any other errors
        print("Unexpected error: $e");
        Get.snackbar('Error', 'An unexpected error occurred');
      }
    }
  }

  Submit() {
    String userPassword = password.text;

  }


  final TextEditingController password = TextEditingController(
    text: '',
  ); // ye bracket password controller ka h

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // ye formkey ka h code that will be used globally

  final TextEditingController email = TextEditingController(
    text: '',
  );
  // this is for email data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child:
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height*0.06,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: Get.height * 0.35,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.6,
                            height: Get.height * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: 'randing',
                                  child: AnimatedDefaultTextStyle(
                                      style: TextStyle(
                                    fontSize: 39,
                                    fontWeight: FontWeight.bold,
                                        color: Colors.grey[900]
                                  ),
                                      duration: Duration(milliseconds: 500),
                                    child: Text(
                                      'Login',
                                    ),
                                  )
                                ),
                                Row(
                                  children: [
                                    Hero(
                                      tag:'ran',
                                      child: Text(
                                        'And',
                                        style:
                                        GoogleFonts.inter(
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
                                        style:
                                        GoogleFonts.inter(
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
                      right: 10,
                      top: 100,
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/4770/9633/14e633dcab172fa7823aa09e26b17a48?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NqLkWw26~-sRfMvOWe6Yt6b0XGXqU-efxH1kkkjaMpsomryA4a~rXU8xU803IHQKuz5Lmgd6Fma-cPI4GjDRPgcbUVa~i~P3OOvS3filqcAPa8gcGFpcnVhoqMdOm6UZPj0QSzJuPsIeBq3bVgaZCTld-lT2VDfvd0FZv~emeuqxXjaUW5zFpbjLTHfMvYDnaHRwugzFrbSaD-qgZslp8md-1xRkdDHqTlq9twCBqqCfTJ1NRR4cGa3rGmgb~KhW49twSxc~R6StW4RTrgBAEL3fINSTtn7-J2lfyQIrfAZJ26V4TD1bs8rGlx9Pk-O2yO86vK3D~jXTXK3Mq1JaTA__',
                        height: Get.height * 0.15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

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

                SizedBox(
                  height: 10,
                ),

                Authinput(
                  validator: ValidationBuilder()
                      .required()
                      .minLength(3)
                      .maxLength(10)

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
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  enableFeedback: true,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      userlogin();
                     logincontroler.setUser(email.text);

                    } else {
                    }
                  },
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
                          'Sign In',
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
                Text('or',
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
              ],
            ),
          ),
        ),
      ),
      ),// safearea  taki appbar ki jagah mile naki cintent upar chipke
    );
  }
}
///.regExp(
//                     RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,10}$'),
//
//                     //Ye RegExp strong password validation ke liye hai. ^ aur $ ensure karte hain ki pura password isi pattern ko follow kare.
//                     //(?=.*[a-z]) ka matlab hai ki kam se kam ek lowercase letter (a-z) hona chahiye.
//                     //(?=.*[A-Z]) confirm karta hai ki kam se kam ek uppercase letter (A-Z) ho.
//                     // (?=.*\d) ek number (0-9) hone ki condition lagata hai,
//                     // aur (?=.*[@$!%*?&]) ensure karta hai ki kam se kam ek special character (@$!%*?&) ho. Finally, [A-Za-z\d@$!%*?&]{6,10} define karta hai ki password ki length 6 se 10 characters ke beech honi chahiye, aur sirf letters, numbers, aur yeh special characters allowed hain.
//                     "Password don't 1 A-Z, 1 a-z, 1 no. & 1 special char ",)
