import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takeittt/Bottomnavpages/Account/Myorders.dart';
import 'package:takeittt/Bottomnavpages/Account/QuestandAns.dart';
import 'package:takeittt/Bottomnavpages/Account/Wishlist.dart';
import 'package:takeittt/Bottomnavpages/Account/coupons.dart';
import 'package:takeittt/Bottomnavpages/Account/review.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/components/searchdelegate.dart';
import 'package:takeittt/components/Wallet.dart';
import 'package:takeittt/routes/routenames.dart';
import 'package:takeittt/Bottomnavpages/Account/editprofile.dart';
import 'package:takeittt/Bottomnavpages/Account/Refer_and_earn.dart';
import 'package:takeittt/utils/tabbar_controller.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? currentUser;
  Stream<DocumentSnapshot>? userStream;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    _initializeUserStream();
  }

  Future<void> _initializeUserStream() async {
    if (currentUser == null) {
      debugPrint('No authenticated user found');
      return;
    }

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser!.uid)
          .get();

      if (doc.exists) {
        debugPrint('Document exists: ${doc.data()}');
        setState(() {
          userStream = FirebaseFirestore.instance
              .collection('User')
              .doc(currentUser!.uid)
              .snapshots();
        });
      } else {
        debugPrint('No document found for UID: ${currentUser!.uid}');
      }
    } catch (e) {
      debugPrint('Error initializing stream: $e');
    }
  }

  Widget _buildUserData() {
    if (currentUser == null) {
      return Center(child: Text('No user logged in'));
    }

    if (userStream == null) {
      return Center(child: Text('Initializing user data...'));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint('Stream error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          debugPrint('No data available for user: ${currentUser!.uid}');
          return Center(child: Text('No user data found'));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        debugPrint('Fetched user data: $userData');

        // Fetch the profile image URL from Supabase
        String? imageUrl = userData['profileImage'] != null
            ? Supabase.instance.client.storage
                .from('Imagedata')
                .getPublicUrl(userData['profileImage'])
            : null;

        return Column(
          children: [
            SizedBox(height: 16),
            Hero(
              tag: 'ran',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                // Only set backgroundImage if imageUrl is not null
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl) : null,
                child: imageUrl == null
                    ? Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Text(
              userData['Name'] ?? 'No Name',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              userData['email'] ?? 'No Email',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MySearchDelegate()),
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic, color: Colors.white),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routenames.cart),
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _initializeUserStream();
          await Future.delayed(Duration(seconds: 1));
          Get.snackbar('Success', 'Page Reloaded',
              dismissDirection: DismissDirection.horizontal);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PREMIUM',
                              style: GoogleFonts.inter(
                                color: Colors.orangeAccent,
                                fontSize: 21,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(1, 0),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(WalletScreen());
                              },
                              icon: Icon(Icons.wallet_outlined,
                                  color: Colors.orangeAccent),
                            )
                          ],
                        ),
                      ),
                      _buildUserData(),
                      Divider(thickness: 2),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Edit Profile'),
                        trailing: Icon(Icons.edit),
                        onTap: () => Get.to(() => EditProfileScreen()),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text('Refer And Earn'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Get.to(() => ReferAndEarnPage()),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.creditCard,
                  size: 20,
                ),
                title: Text('Coupons'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Get.to(ShoppingScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('My Orders'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(MyOrdersScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Wishlist'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(WishlistScreen());
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.reviews),
                title: Text('Reviews'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(ReviewScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Question & Answers'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(FAQScreen());
                },
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 40),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Get.offAllNamed(Routenames.login);
                  },
                  child: Text('Log Out', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
