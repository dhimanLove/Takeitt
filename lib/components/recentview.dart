import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Recentview extends StatefulWidget {
  const Recentview({Key? key}) : super(key: key);

  @override
  _RecentviewState createState() => _RecentviewState();
}

class _RecentviewState extends State<Recentview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Recently Viewed',
          style: GoogleFonts.ubuntu(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: Get.height * 0.007,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/6393197f4aab7aa0fcf943f6d34b903fed3a168e',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Kids'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://cdn4.iconfinder.com/data/icons/wonderful-christmas-3d-1/512/12._Snowman_1024.png',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Gifts'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://static.vecteezy.com/system/resources/previews/036/573/035/non_2x/apple-iwatch-with-beige-strap-free-png.png',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Watches'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://s3-alpha-sig.figma.com/img/3700/732f/2a01730e74b8049d56ccf8b8f193aad2?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ed7lFqpBoXkbWmFEYumeZA~kviz1NggzoPG71WVBj92maDsSKeYWD5OHZHRsw5hZYNgjQE0KED7x5kv4anovW94ks1KdC52ICplT0MQTgx52Qcf~87FFNSaY5byI~kVY4u0Kt~L5rURRplWY8ETCnwKGsCKFBtX5FvPw-tTnK9f79PAkX6JaXYYnRrhnPJtUhMEzHTXwELwZxyFfJid6OyohoZW~Y5pp5dxy134QfBlx407qznyrmdOUhoKIOJ882vhirCl~upi~-Ce2NejjW9LXG4AP4~HYFROE0M1nKVYk6sm1XmAAykAzlgVwYH7pVpCbC3kUBsHf8Hv1TFN6BA__',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Cosmetics'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/5bbfe23c77dba13d3d66f5ac89c635e57a9e1760',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Shoes'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.12,
                        width: Get.width * 0.22,
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_U24Uhh3eNo_xapIMPZAAsIj7TVU3Lb4HTIbkh4re7Vwmk-adG8B4OhSn5oUZKvYkrnQ&usqp=CAU',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: Get.height * 0.12,
                              width: Get.width * 0.22,
                              color: Colors.grey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.03,
                          width: Get.width * 0.22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Heello'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}