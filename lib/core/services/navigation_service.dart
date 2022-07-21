import 'package:al_ameen_customer_service/view/authentication_screens/welcome/welcome_page.dart';
import 'package:al_ameen_customer_service/view/category/categories.dart';
import 'package:al_ameen_customer_service/view/rooms/rooms.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static navigateProcess({BuildContext context, String role}) {
    List toCategoryPage = ['ADMIN', 'Customer', 'Customer Service'];
    List toRoomsPage = ['Programming', 'Accounting', 'Maintainence'];
    if (toCategoryPage.contains(role)) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Categories()));
    } else if (toRoomsPage.contains(role)) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Rooms(
                    roleRoom: role,
                  )));
    } else if (role == 'signIn') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  static navigateProcessOffAll({BuildContext context, String role}) {
    List toCategoryPage = ['ADMIN', 'Customer', 'Customer Service'];
    List toRoomsPage = ['Programming', 'Accounting', 'Maintainence'];
    if (toCategoryPage.contains(role)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Categories()),
          (route) => false);
    } else if (toRoomsPage.contains(role)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Rooms(
                    roleRoom: role,
                  )),
          (route) => false);
    } else if (role == 'signIn') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false);
    }
  }

  static to({BuildContext context, to}) {
    //  it navigate you to another page
    Navigator.push(context, MaterialPageRoute(builder: (context) => to));
  }
}
