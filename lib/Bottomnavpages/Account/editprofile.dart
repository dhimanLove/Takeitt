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
  TextEditingController passwordController = TextEditingController(); // Added for password

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
      Get.snackbar('Error', 'No user logged in',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      return;
    }

    try {
      DocumentSnapshot doc = await _firestore.collection('User').doc(user.uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = data['Name'] ?? '';
          emailController.text = data['email'] ?? user.email ?? '';
          passwordController.text = data['password'] ?? ''; // Fetch password if stored
          _currentImagePath = data['profileImage']; // Fetch profile image path (if exists)
          // Update controller with fetched data
          userController.setUser(nameController.text, emailController.text, _currentImagePath);
        });
      } else {
        Get.snackbar('Error', 'No user data found for this account. Please sign up.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        userController.setProfileImage(_imageFile!); // Temporary local file
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

      Get.snackbar("Success", "Image uploaded successfully",
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
      return path;
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      return null;
    }
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'No user logged in',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      return;
    }

    try {
      String? newImagePath = await _uploadImageToSupabase();

      Map<String, dynamic> userData = {
        'Name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text, // Storing password in Firestore
        'profileImage': newImagePath ?? _currentImagePath, // Store image path (if exists)
      };

      DocumentSnapshot doc = await _firestore.collection('User').doc(user.uid).get();
      if (doc.exists) {
        await _firestore.collection('User').doc(user.uid).update(userData);
        Get.snackbar("Success", "Profile Updated!",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        // Update user controller with new data
        userController.setUser(nameController.text, emailController.text, newImagePath ?? _currentImagePath);
        Get.back();
      } else {
        Get.snackbar('Error', 'No user data found for this account. Please sign up.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile: $e',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> _deleteProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'No user logged in',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      return;
    }

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile'),
        content: const Text('Are you sure you want to delete your profile? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
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
        Get.offAllNamed('/login');
        Get.snackbar("Success", "Profile Deleted!",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'No user data found for this account.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete profile: $e',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
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
                obscureText: true, // Hide password input
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
                onPressed: () {
                  _deleteProfile();
                  Get.toNamed(Routenames.account);
                },
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