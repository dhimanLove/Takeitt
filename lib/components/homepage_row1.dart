import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageRow1 extends StatefulWidget {
  const HomepageRow1({super.key});

  @override
  State<HomepageRow1> createState() => _HomepageRow1State();
}

class _HomepageRow1State extends State<HomepageRow1> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/a9a7373814a3f56699720160d91d66f1cb646e66'),
                ),

                Text(
                  'Male',
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/72b54646f613c734e2ce7d0aeb07655152365039'),
                ),
                 
                Text(
                  'Females',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://cdn4.iconfinder.com/data/icons/black-friday-235/512/Gift_Box.png',
                  fit: BoxFit.contain,
                  ),
                ),

                Text(
                  'Gifts',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://cdn1.iconfinder.com/data/icons/3d-front-color/512/headphone-front-color.png',
                  fit: BoxFit.contain,
                  ),
                ),

                Text(
                  'Music',
                  style: GoogleFonts.ubuntu(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://cdn2.iconfinder.com/data/icons/3d-kitchen-tools/512/Cooker.png',
                  fit: BoxFit.cover,
                  ),
                ),

                Text(
                  'Utensils',
                  style: GoogleFonts.ubuntu(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            Column(
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.17,
                  decoration: BoxDecoration(
                  ),
                  child: Image.network('https://cdn3.iconfinder.com/data/icons/user-interface-2343/512/setting_2.png',
                  fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Gears',
                  style: GoogleFonts.ubuntu(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
