import 'package:get/get.dart';
import 'package:takeittt/Auth/Register.dart';
import 'package:takeittt/Auth/login.dart';
import 'package:takeittt/Bottomnavpages/Account.dart';
import 'package:takeittt/Bottomnavpages/Cart.dart';
import 'package:takeittt/Bottomnavpages/gnavbar.dart';
import 'package:takeittt/components/maps.dart';
import 'package:takeittt/pages/Getstarted.dart';
import 'package:takeittt/pages/homepage.dart';
import 'package:takeittt/routes/routenames.dart';


class Routes{
  static final pages =[
    GetPage(name: Routenames.home, page: ()=>Homepage()),
    GetPage(
        name: Routenames.login,
        page: ()=> Login(),
      transition:Transition.cupertino
    ),
    GetPage(
      name: Routenames.register,
      page: ()=>Register(),
      transition: Transition.cupertino,
    ),
    GetPage(name: Routenames.cart, page: ()=> Cart()),
    GetPage(name: Routenames.maps, page: ()=>Maps()),
    GetPage(name: Routenames.getstart, page: ()=>Getstarted()),
    GetPage(name: Routenames.gnav, page: ()=>GoogleNav()),
    GetPage(name: Routenames.account, page: ()=>Account()),
  ];
}