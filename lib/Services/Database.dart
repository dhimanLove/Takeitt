//This Fille have the code for my Take it Database tasks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseMethods {

  Future addUser(Map<String, dynamic> UserInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(UserInfo);
  }
  Future<Stream<QuerySnapshot>> getUserDetails() async {
    return FirebaseFirestore.instance.collection("User").snapshots();
  }

  Future<void> deleteUserInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .delete();
  }

  Future<void> updateUserData(String id, Map<String, dynamic> updatedData) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .update(updatedData);
  }
}
