import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/signup_screen.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMenu extends StatefulWidget {
  final String userRole;

  CustomMenu({this.userRole});

  @override
  _CustomMenuState createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  List adminMenu = ['انشاء حساب', 'تسجيل الخروج'];
  List userMenu = ['تسجيل الخروج'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      icon: Icon(
        FontAwesomeIcons.ellipsisV,
        color: Colors.white,
        size: 18.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      itemBuilder: (BuildContext context) {
        if (widget.userRole == 'ADMIN') {
          return adminMenu.map((adminM) {
            return PopupMenuItem(
              child: Container(
                  alignment: Alignment.center, child: Text("$adminM")),
              value: adminM,
            );
          }).toList();
        } else {
          return userMenu.map((userM) {
            return PopupMenuItem(
              child:
                  Container(alignment: Alignment.center, child: Text("$userM")),
              value: userM,
            );
          }).toList();
        }
      },
      onSelected: (value) {
        switch (value) {
          case 'تسجيل الخروج':
            {
              SharedPreferencesService().clearUserInfo();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false);
              break;
            }
          case 'انشاء حساب':
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpScreen(userRole: "ADMIN")));

              break;
            }
        }
      },
    );
  }
}
