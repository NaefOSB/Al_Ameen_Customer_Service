import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/core/services/date_service.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomNotification extends StatelessWidget {
  final notification;
  final bool isRead;
  final Function onTap;

  CustomNotification({this.notification, this.isRead,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ListTile(
        tileColor: Colors.transparent,
        title: CustomText(
          title: '${notification['title']}',
          color: Colors.white,
        ),
        subtitle: Text(
          '${notification['notificationMessage']}',
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        trailing: Text(
          '${DateService.getDateString(DateTime.parse(notification['date']))}',
          style: TextStyle(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        onTap: onTap,
        leading: Icon(
          (isRead)
              ? Icons.notifications_none
              : Icons.notifications_active_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
