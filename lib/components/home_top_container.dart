import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/components/rightangletriangle.dart';

class HomeTopContainer extends StatefulWidget {
  const HomeTopContainer({Key? key}) : super(key: key);

  @override
  _HomeTopContainerState createState() => _HomeTopContainerState();
}
class _HomeTopContainerState extends State<HomeTopContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:             Stack(
          children: [

            Container(
              height: Get.height*0.12,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Padding(
                padding:  EdgeInsets.only(top: Get.width*0.08),
                child: Row(children: [
                  IconButton(onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                      icon: Icon(Icons.menu,color: Colors.white,size: Get.width*0.08,)),
                  // SizedBox(height: 50,),

                  Hero(
                    tag: 'takeit',
                    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Text(
                            "TakeIt",
                            style: GoogleFonts.poppins(
                              fontSize: lerpDouble(Get.width * 0.1, Get.width * 0.08, animation.value),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "TakeIt",
                      style: GoogleFonts.inter(
                        shadows: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(1,1)
                          )
                        ],
                        fontSize: Get.width * 0.08,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],),
              ),
            ),
            Positioned(
                right: 0,
                top: Get.width*0,

                child: Container(
                  height: Get.height*0.12,
                  width: Get.width*0.38,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(61))
                  ),
                )),

            Positioned(
              right: Get.width*0.3569,
              top: -Get.width*0.06121,
              child: CustomPaint(
                size: Size(70, 100),
                painter: RightAngleTriangle(),
              ),
            ),

            Positioned(
              right: Get.width*0.03,
              top: Get.width*0.125,
              child: Row(children: [
                Text('Wallet'.tr,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: Get.width*0.049,
                      fontWeight: FontWeight.bold

                  ),),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(Icons.account_balance_wallet),
                )
              ],),
            )
          ],
        ),
    );
  }
}
