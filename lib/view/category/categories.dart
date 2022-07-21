import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/notification_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_chat.dart';
import 'package:al_ameen_customer_service/view/rooms/chat_screen.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_rooms.dart';
import 'package:al_ameen_customer_service/view/rooms/rooms.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_category_card.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:al_ameen_customer_service/view/notification/notification.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var userRole;
  FlutterLocalNotificationsPlugin localNotification;

  // for role Names
  final String customerService = 'Customer Service';
  final String accounting = 'Accounting';
  final String maintenance = 'Maintainence';
  final String programming = 'Programming';
  final String privacy = 'Privacy';

  getNotification() async {
    var notification = await NotificationService.checkIfTheresNewNotification(
        userId: SharedPreferencesService().getUserInfo().userId);
    if (notification != null && notification != 'error') {
      _showNotification(
          title: notification['title'],
          content: notification['notificationMessage']);
    }
  }

  Future _showNotification({String title, String content}) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification", 'this is description',
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(
        0, '$title', '$content', generalNotificationDetails);
  }

  @override
  void initState() {
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);

    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings,onSelectNotification: (payLoad) async{
      NotificationService.onNotificationSelected(context);
    });
    getNotification();
    // TODO: implement initState
    super.initState();
    userRole = SharedPreferencesService().getUserInfo().role;

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: CustomMenu(
              userRole:
                  SharedPreferencesService().getUserInfo().role.toString(),
            ),
            brightness: Brightness.dark,
            title: Text(
              'الأمين لخدمة العملاء',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  fontFamily: 'ElMessiri', fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: 'الأقسام',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: 'التنبيهات',
                  icon: Icon(Icons.notifications_active),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCategoryCard(
                    title: 'قسم خدمة العملاء',
                    icon: FontAwesomeIcons.headset,
                    onTap: () {
                      NavigationService.to(
                          context: context,
                          to: (userRole.toString() == 'Customer')
                              ? ChatScreen(
                                  roleName: customerService,
                                )
                              : Rooms(
                                  roleRoom: customerService,
                                ));
                    },
                  ),
                  CustomCategoryCard(
                    title: 'قسم الحسابات',
                    icon: FontAwesomeIcons.calculator,
                    onTap: () {
                      NavigationService.to(
                          context: context,
                          to: (userRole.toString() == 'Customer')
                              ? ChatScreen(
                                  roleName: accounting,
                                )
                              : Rooms(
                                  roleRoom: accounting,
                                ));
                    },
                  ),
                  CustomCategoryCard(
                    title: 'الصيانة و الدعم الفني',
                    icon: FontAwesomeIcons.tools,
                    onTap: () {
                      NavigationService.to(
                          context: context,
                          to: (userRole.toString() == 'Customer')
                              ? ChatScreen(
                                  roleName: maintenance,
                                )
                              : Rooms(
                                  roleRoom: maintenance,
                                ));
                    },
                  ),
                  CustomCategoryCard(
                    title: 'قسم البرمجيات',
                    icon: FontAwesomeIcons.code,
                    onTap: () {
                      NavigationService.to(
                          context: context,
                          to: (userRole.toString() == 'Customer')
                              ? ChatScreen(
                                  roleName: programming,
                                )
                              : Rooms(
                                  roleRoom: programming,
                                ));
                    },
                  ),
                  (SharedPreferencesService().getUserInfo().role == "ADMIN")
                      ? CustomCategoryCard(
                          title: 'قسم الدردشة الخاصة',
                          icon: FontAwesomeIcons.comments,
                          onTap: () {
                            NavigationService.to(
                                context: context, to: IndividualRooms());
                          },
                        )
                      : FutureBuilder(
                          future: Api.getAllIndividualRoom(
                              SharedPreferencesService().getUserInfo().userId),
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            if (snap != null &&
                                snap.hasData &&
                                snap.data.length > 0) {
                              if (snap.data.length == 1) {
                                return CustomCategoryCard(
                                  title: 'قسم الدردشة الخاصة',
                                  icon: FontAwesomeIcons.comments,
                                  onTap: () {
                                    var room = snap.data;
                                    NavigationService.to(
                                        context: context,
                                        to: IndividualChat(
                                          roomId: room[0]['roomId'],
                                          peerUserId: room[0]['peerUserId'],
                                          peerUserName: room[0]['peerUserName'],
                                        ));
                                  },
                                );
                              }
                              return CustomCategoryCard(
                                title: 'قسم الدردشة الخاصة',
                                icon: FontAwesomeIcons.comments,
                                onTap: () {
                                  NavigationService.to(
                                      context: context, to: IndividualRooms());
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                ],
              ),
              MyNotification(),
            ],
          )),
    );
  }
}
