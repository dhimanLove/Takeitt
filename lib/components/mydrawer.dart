import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeittt/Bottomnavpages/Account.dart';
import 'package:takeittt/Bottomnavpages/Account/editprofile.dart';
import 'package:takeittt/utils/user_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Registercontroller userController = Get.find();
    final Logincontroler loginController = Get.find();

    return Drawer(
      width: Get.width * 0.77, // 70% of screen width
      backgroundColor: Colors.white,
      elevation: 10,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal:
                    Get.width * 0.03,
                vertical: Get.width * 0.015,
              ),
              leading: Hero(
                tag: 'rand',
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.to(Account());
                    },
                    child: CircleAvatar(
                      radius: Get.width *
                          0.08,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          userController.profileImageUrl.value.isNotEmpty
                              ? NetworkImage(
                                  Supabase.instance.client.storage
                                      .from('Imagedata')
                                      .getPublicUrl(
                                          userController.profileImageUrl.value),
                                )
                              : null,
                      onBackgroundImageError: (exception, stackTrace) {
                        Fluttertoast.showToast(
                          msg: "Error loading image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      },
                      child: userController.profileImageUrl.value.isEmpty
                          ? Icon(Icons.person, size: Get.width * 0.08)
                          : null,
                    ),
                  ),
                ),
              ),
              title: Obx(
                () => Text(
                  userController.username.value,
                  style: TextStyle(
                      fontSize: Get.width *
                          0.045), // Scaled font (4.5% of screen width)
                ),
              ),
              subtitle: Obx(
                () => Text(
                  userController.email.value.isNotEmpty
                      ? userController.email.value
                      : loginController.email.value,
                  style: TextStyle(
                      fontSize: Get.width *
                          0.035), // Scaled font (3.5% of screen width)
                ),
              ),
            ),
            Divider(thickness: Get.width * 0.005), // Scaled thickness
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.width *
                      0.05, // Scaled top padding (5% of screen width)
                  left: Get.width *
                      0.03, // Scaled left padding (3% of screen width)
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align items to the left
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(EditProfileScreen());
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: Get.width *
                              0.04, // Scaled font (4% of screen width)
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05), // Scaled spacing
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Refer And Earn',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Coupons',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Question & Answer',
                        style: TextStyle(
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Get.width * 0.05, // Scaled bottom padding
                        right: Get.width * 0.03, // Scaled right padding
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/login');
                        },
                        child: Container(
                          height: Get.width * 0.08, // Scaled height
                          width: Get.width *
                              0.4, // Scaled width (40% of screen width)
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                Get.width * 0.025), // Scaled radius
                          ),
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.04, // Scaled font
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
