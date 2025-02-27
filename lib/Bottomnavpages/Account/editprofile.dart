import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takeittt/utils/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Registercontroller userController = Get.find();
  final Logincontroler loginController = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File? image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController.text = userController.username.value;
    emailController.text = loginController.email.value.isNotEmpty
        ? loginController.email.value
        : userController.email.value;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userController.setProfileImage(File(pickedFile.path));
    }
  }

  void _saveProfile() {
    userController.setUser(nameController.text, emailController.text);
    Get.back();
    Get.snackbar("Success", "Profile Updated!", snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Obx(() => CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: userController.profileImage.value != null
                    ? FileImage(userController.profileImage.value!)
                    : null,
                child: userController.profileImage.value == null
                    ? Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
              ),
            ),

            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Save Changes", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
