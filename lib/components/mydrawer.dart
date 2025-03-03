import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeittt/Bottomnavpages/Account.dart';
import 'package:takeittt/Bottomnavpages/Account/QuestandAns.dart';
import 'package:takeittt/Bottomnavpages/Account/Refer_and_earn.dart';
import 'package:takeittt/Bottomnavpages/Account/Wishlist.dart';
import 'package:takeittt/Bottomnavpages/Account/coupons.dart';
import 'package:takeittt/Bottomnavpages/Account/editprofile.dart';
import 'package:takeittt/Bottomnavpages/Account/review.dart';
import 'package:takeittt/components/Wallet.dart';
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
                          0.045),
                ),
              ),
              subtitle: Obx(
                () => Text(
                  userController.email.value.isNotEmpty
                      ? userController.email.value
                      : loginController.email.value,
                  style: TextStyle(
                      fontSize: Get.width *
                          0.035),
                ),
              ),
            ),
            Divider(thickness: Get.width * 0.005),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.width *
                      0.05,
                  left: Get.width *
                      0.03,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(EditProfileScreen());
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get.to(ReferAndEarnPage());
                      },
                      child: Text(
                        'Refer And Earn',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get.to(ShoppingScreen());
                      },
                      child: Text(
                        'Coupons',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
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
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get.to(WishlistScreen());
                      },
                      child: Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get.to(WalletScreen());
                      },
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get..to(ReviewScreen());
                      },
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.05),
                    GestureDetector(
                      onTap: () {
                        Get.to(FAQScreen());
                      },
                      child: Text(
                        'Question & Answer',
                        style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Get.width * 0.05,
                        right: Get.width * 0.03,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/login');
                        },
                        child: Container(
                          height: Get.width * 0.08,
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
