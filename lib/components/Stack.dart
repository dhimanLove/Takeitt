import 'dart:math';

import 'package:flutter/material.dart';

class MyStackWidget extends StatefulWidget {
  const MyStackWidget({super.key});

  @override
  State<MyStackWidget> createState() => _MyStackWidgetState();
}

class _MyStackWidgetState extends State<MyStackWidget> {
  String? selectedValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40,
          right: 0,
          child: PopupMenuButton<String>(
            onSelected: (String newValue) {
              setState(() {
               selectedValue = newValue;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'English', child: Text('English')),
              PopupMenuItem(value: 'Hindi', child: Text('Hindi')),
              PopupMenuItem(value: 'French', child: Text('French')),
            ],
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                ),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.keyboard_arrow_down_sharp, size: 20),
                  Text(
                    selectedValue ?? "Language",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -30,
          left: 80,
          //box
          child: Transform.rotate(
            angle: pi / 4,
            child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/box.png?raw=true',
              height: 80,
              width: 80,
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: -15,
          child: Transform.rotate(
            //bag and pencil
            angle: pi / 30,
            child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/pencil.png?raw=true',
              height: 80,
              width: 80,
            ),
          ),
        ),
        Positioned(
          top: 160,
          left: 80,
          child: Transform.rotate(
            angle: pi / 40,
            //bucket type something
            child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/basket.png?raw=true',
              height: 70,
              width: 70,
            ),
          ),
        ),
        Positioned(
          top: 300,
          left: -15,
          child: Transform.rotate(
            angle: pi / 9,
            //headphones
            child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/headphones.png?raw=true',
              height: 70,
              width: 70,
            ),
          ),
        ),

        Positioned(
          top: 350,
          left: 80,
          //briefcase
          child:
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start ,
             children: [
               Row(
                  children: [
                    Hero(
                      tag: "ter",
                      child: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          height: 70,
                          child: Text(
                            "TakeIt",
                            style: TextStyle(
                              fontSize: 60, // ✅ Matches destination font size
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: pi / -50,
                      child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/suitcase.png?raw=true',
                        height: 70,
                        width: 80,
                      ),
                    ),
                  ],
                ),
               Text('Shop Smarter, Live Better',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontStyle: FontStyle.italic,
                   fontSize: 18,
                   color: Colors.white,
                 ),
               )
             ],
           ),
        ),

        Positioned(
          top: 500,
          left: -50,
          //apple
          child: Transform.rotate(
            angle: pi / 4,
            child: Image.network('https://github.com/kartikkumarofficial/TakeIt/blob/master/assets/images/onboardingscreen/apple.png?raw=true',
              height: 80,
              width: 80,
            ),
          ),
        ),
      ],
    );
  }
}