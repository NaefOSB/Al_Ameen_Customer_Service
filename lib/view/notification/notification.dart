import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/date_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/model/notification.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_alert_dialog.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_notification.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_notification_details.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_notification_dialog.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyNotification extends StatefulWidget {
  final bool isHaveingAppBar;

  MyNotification({this.isHaveingAppBar = false});

  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  TextEditingController _titleController;
  TextEditingController _contentController;
  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    _titleController = new TextEditingController();
    _contentController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: (widget.isHaveingAppBar)? AppBar(
            brightness: Brightness.dark,
            centerTitle: true,
            title: Text('الإشعارات',style: TextStyle(color: Colors.white),),
            leading: IconButton(onPressed: ()=>Navigator.pop(context),icon:Icon(Icons.arrow_back,color: Colors.white,),)
          ):null,
          body: FutureBuilder(
            future: Api.getUserNotification(
                userId: SharedPreferencesService().getUserInfo().userId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notification = snapshot.data[index];
                    final isRead = notification['isReaded'];
                    return CustomNotification(
                      notification: notification,
                      isRead: isRead,
                      onTap: () {
                        if (!isRead) {
                          // to update the isRead to true if false
                          Api.setReadNotification(notification['userNotificationId']);
                        }
                        showDialog(
                            context: context,
                            builder: (context) => CustomNotificationDetails(
                                  title: '${notification['title']}',
                                  titleColor: Colors.white,
                                  content:
                                      '${notification['notificationMessage']}',
                                  contentColor: Colors.white,
                                  date:
                                      '${DateService.getDateString(DateTime.parse(notification['date']))}',
                                  dateSize: 12.0,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ));
                      },
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return CustomText(
                  title: 'لاتوجد حالياً أي تنبية !!',
                  alignment: Alignment.center,
                );
              }
            },
          ),
          floatingActionButton: (SharedPreferencesService().getUserInfo().role ==
                  "ADMIN")
              ? FloatingActionButton(
                  onPressed: () async {
                    var result = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => CustomNotificationDialog(
                        title: 'أرسل إشعار',
                        titleController: _titleController,
                        contentController: _contentController,
                      ),
                    );

                    if (result == '0' ||
                        result == '1' ||
                        result == '2' ||
                        result == '3') {
                      var adminInfo = SharedPreferencesService().getUserInfo();
                      Notifications notifications = new Notifications(
                          title: _titleController.text,
                          notificationMessage: _contentController.text,
                          id: 0,
                          date: DateTime.now());
                      switch (result) {
                        case '0':
                          {
                            setState(() => _isLoading = true);
                            var api = await Api.sendNotificationToSpecificBranch(
                                branchId: adminInfo.branchId,
                                adminId: adminInfo.userId,
                                notification: notifications,
                                state: "Employees");
                            confirmMessage(success: api);
                            setState(() => _isLoading = false);
                            break;
                          }
                        case '1':
                          {
                            setState(() => _isLoading = true);
                            var api = await Api.sendNotificationToSpecificBranch(
                                branchId: adminInfo.branchId,
                                adminId: adminInfo.userId,
                                notification: notifications,
                                state: "Customers");
                            confirmMessage(success: api);
                            setState(() => _isLoading = false);

                            break;
                          }
                        case '2':
                          {
                            setState(() => _isLoading = true);
                            var api = await Api.sendNotificationToSpecificBranch(
                                branchId: adminInfo.branchId,
                                adminId: adminInfo.userId,
                                notification: notifications,
                                state: "Users");
                            confirmMessage(success: api);
                            setState(() => _isLoading = false);

                            break;
                          }
                        case '3':
                          {
                            setState(() => _isLoading = true);
                            var api = await Api.sendNotificationToAllBranches(
                                notification: notifications,
                                adminId: adminInfo.userId);
                            confirmMessage(success: api);
                            setState(() => _isLoading = false);
                            break;
                          }
                      }
                    }
                  },
                  child: Icon(Icons.add),
                )
              : Container(),
        ),
      ),
    );
  }

  confirmMessage({bool success}) {
    return showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
              title: 'عملية تأكيدية',
              content: (success)
                  ? 'تمت عملية الإرسال بنجاح !!'
                  : 'حدث هنالك خطأ الرجاء المحاولة مرة اُخرى !!',
              firstButtonText: 'موافق',
              contentAlignment: Alignment.center,
              onPressed1: () => Navigator.pop(context),
            ));
  }
}
