import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class TabbarController extends StatefulWidget {
  const TabbarController({Key? key}) : super(key: key);

  @override
  _TabbarControllerState createState() => _TabbarControllerState();
}

class _TabbarControllerState extends State<TabbarController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Coupons',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicator: BubbleTabIndicator(
              indicatorHeight: 40.0,
              indicatorColor: Colors.red.withOpacity(0.4),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            ),
            labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 14),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'New'),
              Tab(text: 'Expiring Soon'),
              Tab(text: 'Exclusive'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CouponList(category: 'All'),
            CouponList(category: 'New'),
            CouponList(category: 'Expiring Soon'),
            CouponList(category: 'Exclusive'),
          ],
        ),
      ),
    );
  }
}

class CouponList extends StatelessWidget {
  final String category;

  const CouponList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$category Coupons',
        style: GoogleFonts.poppins(fontSize: 24),
      ),
    );
  }
}
