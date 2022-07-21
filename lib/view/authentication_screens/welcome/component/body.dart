import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/login/login_screen.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/signup_screen.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            // Image.asset('assets/images/welcome.gif',height: size.height * 0.45,width: 400,fit: BoxFit.cover,),
            Image.asset(
              'assets/images/AmeenIcon.png',
              height: size.height * 0.45,
              width: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "تسجيل الدخول",
              fontSize: 15,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "إنشاء حساب",
              fontSize: 15,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(
                        userRole: 'Customer',
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
