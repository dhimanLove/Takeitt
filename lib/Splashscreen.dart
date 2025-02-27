import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeittt/pages/Getstarted.dart';
import 'package:takeittt/utils/Imagge_cache_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> imageUrls = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _preloadImages();
  }

  Future<void> _preloadImages() async {
    for (String url in imageUrls) {
      await ImageCacheManager.cacheImage(url);
    }

    // After caching all images, navigate to the main screen
    Get.off(() => Getstarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
