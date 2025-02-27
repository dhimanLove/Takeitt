import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takeittt/Bottomnavpages/Account.dart';
import 'package:takeittt/Bottomnavpages/Account/editprofile.dart';

import '../utils/user_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Registercontroller userController = Get.find();
    final Logincontroler loginController = Get.find();
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 10,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              leading:  Hero(
                tag: 'rand',
                child:
                Obx(() => GestureDetector(
                  onTap: (){
                    Get.to(Account())
;                  },
                  child: CircleAvatar(
                    radius: 30,
                    onBackgroundImageError: (exception, stackTrace) {
                      Fluttertoast.showToast(
                        msg: "Error loading image",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    },
                    backgroundColor: Colors.grey,
                    backgroundImage: userController.profileImage.value != null
                        ? FileImage(userController.profileImage.value!)
                        : null,
                  ),
                ),
                ),),
              title:
              Obx(() => Text( userController.username.value, style: TextStyle(fontSize: 20),)),
                //obx se stateful bn jayega ye widget taki getx ke state ko observe karega jab data ayega , ye update hojayega

                subtitle: Obx(() =>  Text(userController.email.value , style: TextStyle(fontSize: 16)),
                   ///// Text(
                  //                   loginController.email.value,

                  //                   style: TextStyle(fontSize: 16),
                  //                 ),
          ),
            ),

            Divider(thickness: 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {
                              Get.to(EditProfileScreen());
                            },
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ),
                    ),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Refer And Earn',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Coupons',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'My Orders',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Wishlist',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Wallet',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Question & Answer',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ))),
                    SizedBox(height: 30),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0, right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.offAllNamed('/login');
                          },
                          child: Container(
                            height: 30,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
