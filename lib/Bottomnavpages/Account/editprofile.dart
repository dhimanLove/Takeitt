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
      print('Fetching data for UID: ${user.uid}');
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        print('Fetched data: $data');
        setState(() {
          nameController.text = data['Name'] ?? '';
          emailController.text = data['email'] ?? user.email ?? '';
          _currentImagePath = data['profileImage'];
          userController.setUser(
            nameController.text,
            emailController.text,
            _currentImagePath,
          );
        });
      } else {
        print('No document found for UID: ${user.uid}');
        setState(() {
          nameController.text = userController.username.value;
          emailController.text = loginController.email.value.isNotEmpty
              ? loginController.email.value
              : user.email ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
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

      print('Uploading image to Supabase: $path');
      await Supabase.instance.client.storage.from('Imagedata').upload(path, _imageFile!);

      if (_currentImagePath != null) {
        print('Removing old image from Supabase: $_currentImagePath');
        await Supabase.instance.client.storage.from('Imagedata').remove([_currentImagePath!]);
      }

      Get.snackbar("Success", "Image uploaded successfully",
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
      return path;
    } catch (e) {
      print('Error uploading image to Supabase: $e');
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
      print('Saving profile for UID: ${user.uid}');
      String? newImagePath = await _uploadImageToSupabase();

      // Prepare data to save (excluding password since it's not edited here)
      Map<String, dynamic> userData = {
        'Name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'profileImage': newImagePath ?? _currentImagePath,
      };

      print('Data to save: $userData');

      DocumentReference docRef = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        print('Updating existing document');
        await docRef.update(userData);
        Get.snackbar("Success", "Profile Updated!",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      } else {
        print('Creating new document');
        // Include password from existing data if available, or skip if not needed
        if (doc.data() != null) {
          var existingData = doc.data() as Map<String, dynamic>;
          userData['password'] = existingData['password']; // Preserve password if exists
        }
        await docRef.set(userData);
        Get.snackbar("Success", "Profile Created!",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      }

      userController.setUser(
        nameController.text.trim(),
        emailController.text.trim(),
        newImagePath ?? _currentImagePath,
      );
      Get.back();
    } catch (e) {
      print('Error saving profile: $e');
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
      print('Deleting profile for UID: ${user.uid}');
      if (_currentImagePath != null) {
        await Supabase.instance.client.storage.from('Imagedata').remove([_currentImagePath!]);
      }
      await _firestore.collection('users').doc(user.uid).delete();
      await _auth.signOut();
      Get.offAllNamed(Routenames.login); // Use Routenames.login
      Get.snackbar("Success", "Profile Deleted!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      print('Error deleting profile: $e');
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
      body: Padding(
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
                // Removed Get.toNamed(Routenames.account) as it conflicts with sign-out
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
    );
  }
}