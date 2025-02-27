import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/Bottomnavpages/products/Laptop.dart';
import 'package:takeittt/Bottomnavpages/products/Mobiles.dart';
import 'package:takeittt/Bottomnavpages/products/Skincare.dart';
import 'package:takeittt/Bottomnavpages/products/Tv.dart';

class HomepageRow2 extends StatefulWidget {
  const HomepageRow2({super.key});

  @override
  State<HomepageRow2> createState() => _HomepageRow2State();
}

class _HomepageRow2State extends State<HomepageRow2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(Tv());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        //color: Color(0xFFCFF2FF),
                      ),
                      height: Get.height * 0.11,
                      width: Get.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                        child: Hero(
                          tag: 'Tv',
                          child: Image.network(
                            'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
                              fit: BoxFit.cover,


                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                          'Tv & Laptop',
                          style: GoogleFonts.ubuntu(
                            fontSize: 12,
                          )
                      ),
                      Text(
                          'From \$200/M',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,),
                      ),
                    ],
                  )
                ],
              )
            ),
            Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(Mobile());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Color(0xFFCFF2FF),
                        ),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Hero(
                          tag: 'Mobile',
                          child: Image.network(
                            'https://itronics.in/wp-content/uploads/2024/09/iPhone_16_Pro_Natural_Titanium_PDP_Image_Position_1__en-IN.png',
                            fit: BoxFit.cover,
                            height: Get.height * 0.1,
                            width: Get.width * 0.3,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            'Mobile Phones',
                            style: GoogleFonts.ubuntu(
                              fontSize: 12,
                            )
                        ),
                        Text(
                          'From \$200/M',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,),
                        ),
                      ],
                    )
                  ],
                )
            ),
            Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(Laptop());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                         // color: Color(0xFFCFF2FF),
                        ),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: 'laptop',
                            child: Image.network(
                              'https://www.apple.com/newsroom/images/2023/10/apple-unveils-new-macbook-pro-featuring-m3-chips/article/Apple-MacBook-Pro-top-view-231030_big.jpg.large.jpg',
                              fit: BoxFit.cover,
                              height: Get.height * 0.1,
                              width: Get.width * 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            'Tv & Laptop',
                            style: GoogleFonts.ubuntu(
                              fontSize: 12,
                            )
                        ),
                        Text(
                          'From \$200/M',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,),
                        ),
                      ],
                    )
                  ],
                )
            ),
            Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(Slkincare());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                         // color: Color(0xFFCFF2FF),
                        ),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Hero(
                          tag: 'Slkincare',
                          child:  Image.asset( 'lib/Assets/cosmetic.png',
                            fit: BoxFit.cover,
                            height: Get.height * 0.1,
                            width: Get.width * 0.3,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            'Cosmetics',
                            style: GoogleFonts.ubuntu(
                              fontSize: 12,
                            )
                        ),
                        Text(
                          'Rs.100/-',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,),
                        ),
                      ],
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
