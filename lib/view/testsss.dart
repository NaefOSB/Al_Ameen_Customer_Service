import 'package:al_ameen_customer_service/core/services/notification_service.dart';
import 'package:al_ameen_customer_service/view/category/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class Testsss extends StatefulWidget {
  @override
  _TestsssState createState() => _TestsssState();
}

class _TestsssState extends State<Testsss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
            color: Colors.deepPurple,
            child: Text(
              'Show Notification',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {}),
      ),
    );
  }
}
