import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeittt/pages/Getstarted.dart';
import 'package:takeittt/routes/route.dart';
import 'package:takeittt/routes/routenames.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:takeittt/utils/user_controller.dart';

void main() async {
  Get.put(Registercontroller());
  Get.put(Logincontroler());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
      url: 'https://tfrqxhncpjpgspwqkqia.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRmcnF4aG5jcGpwZ3Nwd3FrcWlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzcyNzI3MTIsImV4cCI6MjA1Mjg0ODcxMn0.MJZxiJkw-Kp62yM8jbBaoGyd9ZGOY3fRBedCjTGHNdw'
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      print("Microphone permission granted.");
    } else {
      print("Microphone permission denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Getstarted(),
      getPages: Routes.pages,
      initialRoute:FirebaseAuth.instance.currentUser != null ?Routenames.getstart:Routenames.home,
    );
  }
}
