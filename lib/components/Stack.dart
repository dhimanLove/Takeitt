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
            child: Image.network('https://s3-alpha-sig.figma.com/img/4770/9633/14e633dcab172fa7823aa09e26b17a48?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NqLkWw26~-sRfMvOWe6Yt6b0XGXqU-efxH1kkkjaMpsomryA4a~rXU8xU803IHQKuz5Lmgd6Fma-cPI4GjDRPgcbUVa~i~P3OOvS3filqcAPa8gcGFpcnVhoqMdOm6UZPj0QSzJuPsIeBq3bVgaZCTld-lT2VDfvd0FZv~emeuqxXjaUW5zFpbjLTHfMvYDnaHRwugzFrbSaD-qgZslp8md-1xRkdDHqTlq9twCBqqCfTJ1NRR4cGa3rGmgb~KhW49twSxc~R6StW4RTrgBAEL3fINSTtn7-J2lfyQIrfAZJ26V4TD1bs8rGlx9Pk-O2yO86vK3D~jXTXK3Mq1JaTA__',
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
            child: Image.network('https://s3-alpha-sig.figma.com/img/a31f/0a6d/aca5098d1713486fb0789806273e0b3e?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oWu6rzMSEv8e7ZGTo386BF8sRDI7hpSN4b4KwncBZELSTCunYf8UZJKdjAApX7u7de6~CzsXv5GVHQ32LzN8ACUXpDqs5n3lrWbLF2Ao~0dy6T9oxxGPSe7tl6fsJy3HTxyJ8icsiSGiDj1uolaNbe1ItoA2RXsFM8fBG7QEuoO7O0pXK7CfdsjA8-KBQIioNtSkVU~R02O4ZWbhbJXETpUphCiNltF9EL5OLKzJS4DVjusZW8w9Jq7pkBoqJKhzm8OnZ7SM2kEjSeKc1c-hB6rEWuZYpj3rl-tiubdlMKF~97KJIqsKapTWBwkeZSnyRhRsyfaENI8ZrmJPlF1-GA__',
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
            child: Image.network('https://s3-alpha-sig.figma.com/img/f8a7/85e2/52cecd80a7b24aaa42786ce6121fc8be?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Z33gxRy2zvTaX5d6YYtxW2sLrOV3mMF8tv35WXLJH-3vWxmDyBjG3dIR~KqEFCe~HJDGlO8fT03jjq7cp-T2kRymGX9P6K0434U5WIkOmQx6VMtXSnPoSWvY5-IVs-gVOe7wdTJ20sQEdcyWRstmRbUZgzaeLpFS00HGv6EVUswzMe-zVRLnB~0IzldNMRF5Nf4pNIAWn6Gft-DIopSP8BXIokKrmKKIRnJYmU-GhKUBtsOCwBYC0lpdefPaewrislO3tqC4AadZqZoDcCSTH~5ql80EVx3FPIv9jRgCWpz0obNr6HrUSg1f~PeTEqwxzEFxa5aOEiTbUjkHeVz3Yw__',
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
            child: Image.network('https://s3-alpha-sig.figma.com/img/b544/c26f/fbb6a65ecfba4e023607f61cc49e6e75?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ZKWP3HfwfWfTymWwNxJYzMeU8PzrDAPnvX9ZgDnYVm2VjRyujFjEdR-yuhL-bZTtfmPBFuIcahkbePUGcRQTW7G5mWlGucxsopBYpQVoJvIbgnpgnmUIXVJ9jIE180psH4aSjECLN-82iefCLQr6ZGBf3pdfpuSBQsoQJzctQ453mDEcrkMXJTGtiNwB0k3jaxJ2-dNRESU-9arUWD52PoBbE0U7rgyUuTfCknEHFFPfIEhgiNeBFSjkCpG46bcuKKV8eihDydBNvRWbEiOPjrDjc5waxEZHYpcKuEyC2-UJBK4IWTi2l9AkyT9qawR52b~lhqetDMgd1Wrum3Rncw__',
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
                      child: Image.network('https://s3-alpha-sig.figma.com/img/d10e/eab5/6b378909510f535d82c3d7cb1438a5f0?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Uh-1kVcZxLcj65BYNuYjNGYZfWHtIbqbPqT431O~9LOeydo7QV2zSWMl2Tbk2EvhmMoK6qytmnwdJw8SJPvnjqBl2LmcjSMfcvM7tSeLaEhXMeFcLkN41xVl6NLoOuTVkjKKdQ00WIFuzeCMR0ZMV8gvdFBbeIRQ5tXsLM4rMzeH3C2w9UWKHZmwdEwk3r9bG7adxE5d0pvVPp6Tbd2uH~R2XmsDH70Q9dTHksniSgE36thQgR3FnGVZRz2wEx9tKsTykT1KOIA7uAZD5DPQGfOGlmiT1YfIuq--jYeXw-qJRwjYPvJQri5sSWR5IpRQ3OuTdRWadUg7TTktbC3wqw__',
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
            child: Image.network('https://s3-alpha-sig.figma.com/img/7d88/30d5/c7050837d2306bda6a4aee9b238bf984?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=H-1UHestMXv5cN8dFkFvvVf2Oboe-bEdYRiDhtqynWVx2vnJkxKD9Bn8JWjsvtyMSDhIHAbd5cluY-OCU6XRKXMoZ0WJ3ctFVP9mxr1g3oQLuPv8ESWsnBktsB0Gk7NiRUtJRz-ai4qvO1ledE-NcYTGcYJa5LXTwu010P-4Nor~UaYa8o-07xt36KT-QZYUfp~7pcyhHVliT0W6~TUF2bN~GKXSY9ii~ZipKi7hE4plcKy9K10WGa32hyW6tPEe96ktZ9g5jR1tdkjr0trMHHiiCaxI5~xRxz6BEVFrFrqdVDjFgspSQR3NCvB6XYSz~fWDPXQLB7viqStP4s-RpA__',
              height: 80,
              width: 80,
            ),
          ),
        ),
      ],
    );
  }
}