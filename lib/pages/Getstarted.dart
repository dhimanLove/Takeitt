
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeittt/Auth/Register.dart';
import 'package:takeittt/Auth/login.dart';
import 'package:takeittt/components/Stack.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() => _GetstartedState();
}

class _GetstartedState extends State<Getstarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                child:MyStackWidget(),
            ),
            Positioned(
                top: 680,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 100,
                  //color: Colors.red,
                  child: Column(
                                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Text("Quality, affordability and convenience in every click",style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: 40,
                        child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.orangeAccent),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                            onPressed: (){
                            Get.to(Register(),
                              transition: Transition.cupertino,
                              popGesture:true,
                              // preventDuplicates: false,
                              curve: Curves.easeInOut,
                            );
                            },
                            child:
                            Text('GET STARTED',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
