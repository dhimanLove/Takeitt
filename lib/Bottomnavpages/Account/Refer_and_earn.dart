import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:takeittt/components/referalbottomsheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferAndEarnPage extends StatefulWidget {


  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  String message = "Hey! Join EcoTrack and use my referral code: ECO1234";

  void shareOnInstagram() async {
    String url = "https://www.instagram.com/direct/new/";  // Opens Instagram DM screen

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch Instagram");
    }
  }

  final String referralCode = "ECO1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Refer & Earn")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Invite Friends & Earn Rewards!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            Text(
              "Share your referral code and earn 100 coins for each friend who joins using your code.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: Get.height*0.1,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.blue),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: referralCode),
                      );
                      Get.snackbar("Copied!", "Referral code copied to clipboard.",
                          backgroundColor: Colors.blue, colorText: Colors.white);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                showReferralBottomSheet(context);
              },
              icon: Icon(Icons.share),
              label: Text("Share Code"),
            ),

            SizedBox(height: 80),

            Image.network(
              "https://cdn2.iconfinder.com/data/icons/banking-3d-illustrations/256/earn-money-online-profit-dollar-3d-render.png",
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
