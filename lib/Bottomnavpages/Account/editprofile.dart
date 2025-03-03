import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takeittt/routes/routenames.dart';
import 'package:takeittt/utils/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Registercontroller userController = Get.find();
  final Logincontroler loginController = Get.find();
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  File? _imageFile;
  String? _currentImagePath;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.rawSnackbar(
        message: 'No user logged in',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      DocumentSnapshot doc = await _firestore.collection('User').doc(user.uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = data['Name'] ?? '';
          emailController.text = data['email'] ?? user.email ?? '';
          passwordController.text = data['password'] ?? '';
          _currentImagePath = data['profileImage'];
          userController.setUser(nameController.text, emailController.text, _currentImagePath);
        });
      } else {
        Get.rawSnackbar(
          message: 'No user data found. Please sign up.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        message: 'Failed to fetch user data: $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        userController.setProfileImage(_imageFile!);
      });
    }
  }

  Future<String?> _uploadImageToSupabase() async {
    if (_imageFile == null) return _currentImagePath;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String path = "Imagedata/$fileName";

      await Supabase.instance.client.storage.from('Imagedata').upload(path, _imageFile!);

      if (_currentImagePath != null) {
        await Supabase.instance.client.storage.from('Imagedata').remove([_currentImagePath!]);
      }

      Get.rawSnackbar(
        message: 'Image uploaded successfully',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
      return path;
    } catch (e) {
      Get.rawSnackbar(
        message: 'Failed to upload image: $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
      return null;
    }
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.rawSnackbar(
        message: 'No user logged in',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      String? newImagePath = await _uploadImageToSupabase();

      Map<String, dynamic> userData = {
        'Name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'profileImage': newImagePath ?? _currentImagePath,
      };

      DocumentSnapshot doc = await _firestore.collection('User').doc(user.uid).get();
      if (doc.exists) {
        await _firestore.collection('User').doc(user.uid).update(userData);
        Get.rawSnackbar(
          message: 'Profile Updated!',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
        );
        userController.setUser(nameController.text, emailController.text, newImagePath ?? _currentImagePath);
        Get.back();
      } else {
        Get.rawSnackbar(
          message: 'No user data found. Please sign up.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        message: 'Failed to save profile: $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> _deleteProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.rawSnackbar(
        message: 'No user logged in',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
      return;
    }

    bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Profile'),
        content: const Text('Are you sure you want to delete your profile? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      DocumentSnapshot doc = await _firestore.collection('User').doc(user.uid).get();
      if (doc.exists) {
        if (_currentImagePath != null) {
          await Supabase.instance.client.storage.from('Imagedata').remove([_currentImagePath!]);
        }
        await _firestore.collection('User').doc(user.uid).delete();
        await _auth.signOut();
        Get.offAllNamed(Routenames.login);
        Get.rawSnackbar(
          message: 'Profile Deleted!',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
        );
      } else {
        Get.rawSnackbar(
          message: 'No user data found.',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        message: 'Failed to delete profile: $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Obx(() => CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : userController.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(Supabase.instance.client.storage
                      .from('Imagedata')
                      .getPublicUrl(userController.profileImageUrl.value))
                      : null,
                  child: _imageFile == null && userController.profileImageUrl.value.isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
                )),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deleteProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Delete Profile", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}