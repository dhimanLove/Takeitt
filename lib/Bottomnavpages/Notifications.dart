import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/components/maps.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/routes/routenames.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
            ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routenames.maps);
                },
                child: Card(
                  semanticContainer: true,  // Helps with accessibility
                  elevation: 3,
                  color: Colors.blue,
                  borderOnForeground: true,
                  child:
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: Get.height * 0.23,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.pexels.com/photos/7363190/pexels-photo-7363190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.height * 0.07,
                          width: Get.width * 0.92,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            'Track the Delivery Status',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                color: Colors.blue,
                borderOnForeground: true,
                child:
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: Get.height * 0.23,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.pexels.com/photos/7363190/pexels-photo-7363190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Overlay Content Here', // Replace with actual content
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                color: Colors.blue,
                borderOnForeground: true,
                child:
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: Get.height * 0.23,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.pexels.com/photos/7363190/pexels-photo-7363190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Overlay Content Here',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                color: Colors.blue,
                borderOnForeground: true,
                child:
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: Get.height * 0.23,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),

                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.pexels.com/photos/7363190/pexels-photo-7363190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Overlay Content Here', // Replace with actual content
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
