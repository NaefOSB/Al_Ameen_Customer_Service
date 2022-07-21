import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/component/body.dart';

class SignUpScreen extends StatelessWidget {
  final String userRole;

  SignUpScreen({this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(userRole: userRole.toString(),),
    );
  }
}