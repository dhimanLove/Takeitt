import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlecont extends StatefulWidget {
  const Googlecont({super.key});

  @override
  State<Googlecont> createState() => _GooglecontState();
}

class _GooglecontState extends State<Googlecont> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GoogleSignIn().signIn,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 35,
        ),
        height: Get.height*0.05,
        width: MediaQuery.of(context).size.width * 2,
        decoration: BoxDecoration(
          //color: Colors.orange,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:25
          ),
          child: Row(
            children: [
              Image.network(
                'https://s3-alpha-sig.figma.com/img/9690/3368/9b71a1845255c9f583f1866f305d4aec?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=qSoDog1bZhYI62gj6qto4VuWr75rwgv~p2cvqbNEayOhkl0f1~mS76vD4Hqok1bndTp85LYbjuA85uxRKA2Z6tlga-zTsB8qThtNthIsy2WWudgs~nZGOgm07cw7TtCfwZ1rw06FyUcnWYdDr7OihL2v2LzHX58MgDaKVWBkrG~UtA72SWZgYjzlkh9xy6sMZ6ORs9Oto54FP~EKslO5X2StE0xW72zaxmOaCNWK6bC-l7S3V2FpAe~qFgsRMTfFZKtR9Ox2seD6NGFrpLJDyWRsykxS4lmqgpRchCZGcscdo5IVTdlL059N~1WFuSh1JbBhVEr8TY3BjGtZHJqQkw__',
                height: Get.height*0.027,
              ),
              SizedBox(width: 10),
              Text(
                'Continue with Google',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
