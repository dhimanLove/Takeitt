import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:takeittt/Bottomnavpages/Account.dart';
import 'package:takeittt/Bottomnavpages/Cart.dart';
import 'package:takeittt/Bottomnavpages/Categories.dart';
import 'package:takeittt/Bottomnavpages/Notifications.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/pages/homepage.dart';

class GoogleNav extends StatefulWidget {
  const GoogleNav({super.key});

  @override
  State<GoogleNav> createState() => _GoogleNavState();
}

class _GoogleNavState extends State<GoogleNav> {
  int _selectedIndex = 0;
  final PageController pageController = PageController();

  final List<Widget> _pages = [
    Homepage(),
    Categories(),
    Cart(),
    Notifications(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                pageController.jumpToPage(index);
                setState(() {
                  _selectedIndex = index;
                });
              },
              activeColor: Colors.blue,
              gap: 8,
              rippleColor: Colors.blue,
              tabBackgroundColor: Colors.grey[200]!,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.list_rounded, text: 'Category'),
                GButton(icon: Icons.shopping_cart, text: 'Cart'),
                GButton(icon: Icons.notifications_none, text: 'Notifications'),
                GButton(icon: Icons.person_outline, text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
