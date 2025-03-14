import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:takeittt/components/Homepage_row2.dart';
import 'package:takeittt/components/Searchbar.dart';
import 'package:takeittt/components/home_top_container.dart';
import 'package:takeittt/components/homepage_row1.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/components/recentview.dart';
import 'package:takeittt/components/snacbars.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: Get.height * 0.034),
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.109,
                  width: double.infinity,
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Searchbar(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(

                        child: Text(
                          '221B Baker Street, London, NW1 6XE, UK',
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://s3-alpha-sig.figma.com/img/0271/75bf/3ad98239ac7e14be92d54bf9c5cc3dc4?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=cPH53xjXKT1SNRNN4j4srOe8A0aIr7frg93ehSxMXnYofjGLfLcuSKtZw9BsGXx-y5keoJ-Q0rLzbUHKDOhygn0yCQz~dug7qjHVRYF~AUTvFbfrGwCE~1-nVsYDMHGEx4K55ijI4F9wfa2nYileXtAGacIUBumTene40thAeqa~I9BSdHokVzI-8ssaAx-AUBf3-1J~4FpB1LxaMsIFPzEdFUbY~tDNs-nTzWS5BGcibwtml765cWWGIwc9WpPsjnjwg8TytrOP~ca7Ryt54nix7f-sOuw5CE-UlXLcQVfREtbS4TcBoPjzO76nRzzBEoA4yHlTJO1sLlo5GuWatg__',
                                        ),
                                        fit: BoxFit.cover)),
                                height: MediaQuery.of(context).size.height * 0.26,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 160,
                                      left: 30,
                                      child: containerWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://images.pexels.com/photos/9204671/pexels-photo-9204671.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                        ),
                                        fit: BoxFit.cover)),
                                height: MediaQuery.of(context).size.height * 0.26,
                                width: MediaQuery.of(context).size.width, // Full screen width for each container
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 160,
                                      left: 30,
                                      child: containerWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                        ),
                                        fit: BoxFit.cover)),
                                height: MediaQuery.of(context).size.height * 0.26,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 160,
                                      left: 30,
                                      child: containerWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      HomepageRow1(),
                      SizedBox(height: 7),
                      HomepageRow2(),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: Recentview(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HomeTopContainer(),
          ),
        ],
      ),
    );
  }
}

//explore it container
Widget containerWidget() {
  return Container(
    height: Get.height * 0.04,
    width: Get.width * 0.24,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        'Explore it',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

