import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
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
                      onTap: () {
                        Get.to(Tv());
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Hero(
                            tag: 'Tv',
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.grey),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error, size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                            'Tv & LCD',
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
                      onTap: () {
                        Get.to(Mobile());
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Hero(
                          tag: 'Mobile',
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://itronics.in/wp-content/uploads/2024/09/iPhone_16_Pro_Natural_Titanium_PDP_Image_Position_1__en-IN.png',
                            fit: BoxFit.cover,
                            height: Get.height * 0.1,
                            width: Get.width * 0.3,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(color: Colors.grey),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error, size: 40),
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
                          'From \$20/M',
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
                      onTap: () {
                        Get.to(Laptop());
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: 'laptop',
                            child: FadeInImage(
                              placeholder: AssetImage('lib/Assets/mac.png'),
                              image: AssetImage('lib/Assets/mac.png'),
                              fadeInDuration: Duration(milliseconds: 300),
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
                      onTap: () {
                        Get.to(Slkincare());
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        height: Get.height * 0.11,
                        width: Get.width * 0.3,
                        child: Hero(
                          tag: 'Skincare',
                          child: FadeInImage(
                            placeholder:NetworkImage('https://cdn0.iconfinder.com/data/icons/workly-startup-work-environment-character/256/2._Work_In_Beanbag.png'),
                            image: AssetImage('lib/Assets/cosmetic.png'),
                            fadeInDuration: Duration(milliseconds: 300),
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