import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/notification/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationService{
  static checkIfTheresNewNotification({String userId}) async{
    try {
      var notifications = await Api.getUserNotification(userId: userId) as List;
      if (notifications.length > 0) {
        for (int i = 0; i < notifications.length; i++) {
          if (notifications[i]['isReaded'] == false) {
            return notifications[i];
          }
        }
      }
    }catch(e){
      return 'error';
    }
  }

  static onNotificationSelected(BuildContext context){
    Api.setAllNotification(SharedPreferencesService().getUserInfo().userId);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyNotification(isHaveingAppBar: true,)));
  }
}