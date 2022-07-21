import 'dart:async';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getUserData() {
    var user = SharedPreferencesService().getUserInfo();
    if (user.userId.isNotEmpty && user.role.isNotEmpty) {
      NavigationService.navigateProcess(context: context, role: user.role);
    } else {
      NavigationService.navigateProcess(context: context, role: 'signIn');
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 1), () => getUserData());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            height: size.height / 2.7,
            child: Column(
              children: [
                Image.asset('assets/images/AmeenIcon.png'),
                CustomText(
                  title: 'Powered by Novelsoft',
                  alignment: Alignment.center,
                  color: Colors.lightBlue.shade500,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          )),
    );
  }
}
