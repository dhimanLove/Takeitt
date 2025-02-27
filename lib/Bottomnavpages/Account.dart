
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takeittt/Bottomnavpages/Account/Refer_and_earn.dart';
import 'package:takeittt/Bottomnavpages/Account/editprofile.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/components/searchdelegate.dart';
import 'package:takeittt/routes/routenames.dart';

import '../utils/user_controller.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Registercontroller userController = Get.find();
  final Logincontroler loginController = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.blue,
        title: Text('Profile'
            ,style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          }, icon: Icon(Icons.search,color: Colors.white,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.mic,color: Colors.white,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart,color: Colors.white,)),
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
         Get.snackbar('Success',
              'Page Reloaded',
           dismissDirection: DismissDirection.horizontal,

         );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    )
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Hero(
                        tag: 'rando',
                        child:
                        Obx(() => GestureDetector(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: userController.profileImage.value != null
                                ? FileImage(userController.profileImage.value!)
                                : null,
                            child: userController.profileImage.value == null
                                ? Icon(Icons.person, size: 50, color: Colors.white)
                                : null,
                          ),
                        )),),

                    Obx(() => Column(
                        children: [
                          Text(
                            userController.username.value,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            userController.email.value ,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )),
                      Obx(() => Text(
                        loginController.email.value,
                        style: TextStyle(fontSize: 16),
                      ),
                      ), //obx to give stateful properties to it
                      Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Edit Profile'),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          Get.to(EditProfileScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text('Refer And Earn'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(ReferAndEarnPage());
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('My Orders'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Wishlist'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.reviews),
                title: Text('Reviews'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Question & Answers'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    Get.offAllNamed(Routenames.login);
                  },
                  child: Text('Log Out', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
