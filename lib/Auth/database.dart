import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static Future addUser(Map<String, dynamic> userinfomap, String id) async {
    return await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .set(userinfomap);
  }
  Future <Stream<QuerySnapshot>> getUser()async{
    return await FirebaseFirestore.instance.collection('User').snapshots();
  }
}
