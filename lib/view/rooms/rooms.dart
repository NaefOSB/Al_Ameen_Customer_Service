import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/date_service.dart';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/notification_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/component/dropdown_button.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_chat.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_rooms.dart';
import 'package:al_ameen_customer_service/view/notification/notification.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_alert_dialog.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_chat_tile.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_circular_button.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'chat_screen.dart';

class Rooms extends StatefulWidget {
  final String roleRoom;

  Rooms({this.roleRoom});

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> with SingleTickerProviderStateMixin {
  FlutterLocalNotificationsPlugin localNotification;
  bool isStretchedDropDown = false;
  List branch = [];
  String title = '';
  var selectedBranchId;
  int groupValue;
  bool _isCategoryVisible = true;
  bool _isSearchVisible = false;
  TextEditingController _searchController = new TextEditingController();

  void getBranches() async {
    Api api = new Api();
    branch = await api.getAllBranches() as List;
    for (int i = 0; i < branch.length; i++) {
      if (branch[i]['id'] == selectedBranchId) {
        setState(() {
          groupValue = i;
          title = branch[i]['name'];
        });
      }
    }
  }

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

  //For Floating Button
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);

    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings,
        onSelectNotification: (payLoad) async {
      NotificationService.onNotificationSelected(context);
    });
    getNotification();

    selectedBranchId = SharedPreferencesService().getUserInfo().branchId;

    getBranches();
    super.initState();

    //For Floating Button
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    //First Button
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    //Second Button
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.3), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.3, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    //Third Button
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.40), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.40, end: 1.0), weight: 65.0),
    ]).animate(animationController);

    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade500,
        body: Column(
          children: [
            // ---------------- Header -----------------------

            Visibility(
              visible: _isCategoryVisible,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isStretchedDropDown = !isStretchedDropDown;
                      if (branch.length < 1) {
                        getBranches();
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(27))),
                              child: Column(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                        minHeight: 45,
                                        minWidth: double.infinity,
                                      ),
                                      alignment: Alignment.center,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 80,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.search,
                                                            color: (_isSearchVisible)
                                                                ? kPrimaryColor
                                                                : kPrimaryColor
                                                                    .withOpacity(
                                                                        0.4),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _isCategoryVisible =
                                                                  false;
                                                              _isSearchVisible =
                                                                  true;
                                                            });
                                                          }),
                                                      Expanded(
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .location_city,
                                                              color: (_isCategoryVisible)
                                                                  ? kPrimaryColor
                                                                  : kPrimaryColor
                                                                      .withOpacity(
                                                                          0.4),
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _isCategoryVisible =
                                                                    true;
                                                                _isSearchVisible =
                                                                    false;
                                                                _searchController
                                                                    .clear();
                                                              });
                                                            }),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 0),
                                                  child: Text(
                                                    title,
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'ElMessiri'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Icon(
                                                  isStretchedDropDown
                                                      ? Icons.arrow_upward
                                                      : Icons.arrow_downward,
                                                  color: kPrimaryColor),
                                            )
                                          ],
                                        ),
                                      )),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ExpandedSection(
                                      expand: isStretchedDropDown,
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount: branch.length,
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return RadioListTile(
                                              title: CustomText(
                                                title: branch[index]['name'],
                                              ),
                                              value: index,
                                              groupValue: groupValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  groupValue = val;
                                                  title = branch[index]['name'];
                                                  selectedBranchId =
                                                      branch[index]['id'];
                                                  isStretchedDropDown =
                                                      !isStretchedDropDown;
                                                });
                                              });
                                        },
                                      ),

                                      // ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isSearchVisible,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) {
                    setState(() {});
                  },
                  style: TextStyle(fontFamily: 'ElMessiri'),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Container(
                        width: 80,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: (_isSearchVisible)
                                          ? kPrimaryColor
                                          : kPrimaryColor.withOpacity(0.4),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isCategoryVisible = false;
                                        _isSearchVisible = true;
                                      });
                                    }),
                                Expanded(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.location_city,
                                        color: (_isCategoryVisible)
                                            ? kPrimaryColor
                                            : kPrimaryColor.withOpacity(0.4),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isCategoryVisible = true;
                                          _isSearchVisible = false;
                                          _searchController.clear();
                                        });
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri')),
                ),
              ),
            ),

            // ---------------- Body -------------------------
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                  child: FutureBuilder(
                    future: Api.getRoomsFiltered(
                        (widget.roleRoom.isNotEmpty)
                            ? widget.roleRoom
                            : SharedPreferencesService().getUserInfo().role,
                        selectedBranchId),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot != null && snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var room = snapshot.data[index];
                            // for search text
                            if (room['userName']
                                .toString()
                                .contains(_searchController.text)) {
                              return CustomChatTile(
                                userName: '${room['userName'].toString()}',
                                onTap: () {
                                  if (widget.roleRoom.isNotEmpty) {
                                    //  for admin because if the employee is the current user the roleRoom will be null
                                    NavigationService.to(
                                        context: context,
                                        to: ChatScreen(
                                          roleName: widget.roleRoom,
                                          customerId: room['userId'],
                                          roomId: room['roomId'],
                                          userName:
                                              '${room['userName'].toString()}',
                                        ));
                                  } else {
                                    // for employee
                                    NavigationService.to(
                                        context: context,
                                        to: ChatScreen(
                                          roleName: SharedPreferencesService()
                                              .getUserInfo()
                                              .role,
                                          customerId: room['userId'],
                                          roomId: room['roomId'],
                                          userName:
                                              '${room['userName'].toString()}',
                                        ));
                                  }
                                },
                                date:
                                    '${DateService.getDateString(DateTime.parse(room['lastDate'].toString()))}',
                                msg: room['lastMSG'],
                                seen: false,
                              );
                            } else {
                              return Text('');
                            }
                          },
                        );
                      } else {
                        return CustomText(
                          title: 'لايوجد هناك اي محادثات حالياً',
                          alignment: Alignment.center,
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: getFLoatingButton(),
      ),
    );
  }

  Widget getFLoatingButton() {
    var role = SharedPreferencesService().getUserInfo().role;
    if (role == 'ADMIN' || role == 'Customer') {
      return Container();
    }
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IgnorePointer(
                    child: Container(
                      color: Colors.transparent,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degOneTranslationAnimation.value * 120),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CustomCircularButton(
                        color: Colors.blue,
                        width: 50,
                        height: 50,
                        tooltip: 'المحادثات الخاصة',
                        icon: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        onClick: () async {
                          var rooms = await Api.getAllIndividualRoom(
                              SharedPreferencesService().getUserInfo().userId);
                          print(rooms);
                          print(rooms.length);
                          if (rooms != null && rooms.length == 1) {
                            NavigationService.to(
                                context: context,
                                to: IndividualChat(
                                  roomId: rooms[0]['roomId'],
                                  peerUserId: rooms[0]['peerUserId'],
                                  peerUserName: rooms[0]['peerUserName'],
                                ));
                          } else if (rooms != null && rooms.length > 1) {
                            NavigationService.to(
                                context: context, to: IndividualRooms());
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                      title: 'لايوجد اي دردشة',
                                      content: 'لاتوجد اي دردشة حاليا !!',
                                      contentAlignment: Alignment.center,
                                      firstButtonText: 'موافق',
                                      onPressed1: () => Navigator.pop(context),
                                    ));
                            print(SharedPreferencesService()
                                .getUserInfo()
                                .userName);
                          }
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degTwoTranslationAnimation.value * 120),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degTwoTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CustomCircularButton(
                        // color: Colors.black,
                        color: Color(0xFF363636),
                        width: 50,
                        height: 50,
                        tooltip: 'الأشعارات',
                        icon: Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                        ),
                        onClick: () {
                          NavigationService.to(
                              context: context,
                              to: MyNotification(
                                isHaveingAppBar: true,
                              ));
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degThreeTranslationAnimation.value * 120),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degThreeTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CustomCircularButton(
                        // color: Colors.black,
                        color: Colors.indigo,
                        width: 50,
                        height: 50,
                        tooltip: 'تسجيل الخروج',
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onClick: () => Api.signOut(context: context),
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)),
                    alignment: Alignment.center,
                    child: CustomCircularButton(
                      // color: Color(0xFFC42470),
                      color: Colors.lightBlue.shade400,
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onClick: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
