import 'package:dictionary/Controller/datacontroller.dart';
import 'package:dictionary/Screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () async {

          Get.to( Homepage());
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.black,
        ),
      ),
    );
  }
}
