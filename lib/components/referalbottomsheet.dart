import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void showReferralBottomSheet(BuildContext context) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Share & Earn Rewards",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1,
            children: [
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://wa.me/?text=${Uri.encodeComponent('Use my referral code: ECO1234')}"));
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green.shade50,
                      child: Icon(FontAwesomeIcons.whatsapp,
                          size: 30, color: Colors.green),
                    ),
                    SizedBox(height: 5),
                    Text("WhatsApp",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse("https://www.instagram.com/direct/new/"),
                      mode: LaunchMode.externalApplication);
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.pink.shade50,
                      child: Icon(FontAwesomeIcons.instagram,
                          size: 30, color: Colors.pink),
                    ),
                    SizedBox(height: 5),
                    Text("Instagram",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent('https://yourapp.com/referral')}"));
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(FontAwesomeIcons.facebook,
                          size: 30, color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Text("Facebook",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://t.me/share/url?url=${Uri.encodeComponent('https://yourapp.com/referral')}&text=${Uri.encodeComponent('Use my referral code: ECO1234')}"));
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(FontAwesomeIcons.telegram,
                          size: 30, color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Text("Telegram",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String subject = Uri.encodeComponent("Join me on Take-it");
                  String body = Uri.encodeComponent(
                      "Use my referral code: ECO1234 to sign up.");
                  String emailUrl = "mailto:?subject=$subject&body=$body";
                  launchUrl(Uri.parse(emailUrl));
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red.shade50,
                      child: Icon(Icons.email, size: 30, color: Colors.red),
                    ),
                    SizedBox(height: 5),
                    Text("Email",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: "ECO1234"));
                  Get.snackbar("Copied!", "Referral code copied to clipboard.",
                      backgroundColor: Colors.blue, colorText: Colors.white);
                  Get.back();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.copy, size: 30, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text("Copy Code",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
