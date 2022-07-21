import 'dart:math';
import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/component/dropdown_button.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_chat.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Users extends StatefulWidget {
  final String roleRoom;

  Users({this.roleRoom});

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  FlutterLocalNotificationsPlugin localNotification;
  bool isStretchedDropDown = false;
  List branch = [];
  String title = '';
  var selectedBranchId;
  int groupValue;
  bool _isCategoryVisible = true;
  bool _isSearchVisible = false;
  TextEditingController _searchController = new TextEditingController();
  FocusNode _searchNode = FocusNode();

  Color mainColor = Colors.lightBlue.shade500;
  var containerRadius = Radius.circular(30.0);
  bool _isLoading = false;

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

  @override
  void initState() {
    selectedBranchId = SharedPreferencesService().getUserInfo().branchId;

    getBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Scaffold(
          backgroundColor: mainColor,
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
                                                                _searchNode
                                                                    .requestFocus();
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
                                                          color:
                                                              Colors.grey[700],
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return RadioListTile(
                                                title: CustomText(
                                                  title: branch[index]['name'],
                                                ),
                                                value: index,
                                                groupValue: groupValue,
                                                onChanged: (val) {
                                                  setState(() {
                                                    groupValue = val;
                                                    title =
                                                        branch[index]['name'];
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
                    focusNode: _searchNode,
                    controller: _searchController,
                    onChanged: (v) {
                      setState(() {});
                    },
                    style: TextStyle(fontFamily: 'ElMessiri'),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                        border: InputBorder.none,
                        icon: Container(
                          // color: Colors.red,
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
                                          _searchNode.requestFocus();
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
                        topLeft: containerRadius, topRight: containerRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0),
                    child: FutureBuilder(
                      future: Api.getUsersByBranch(
                          userId:
                              SharedPreferencesService().getUserInfo().userId,
                          branchId: selectedBranchId),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot != null &&
                            snapshot.data.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var user = snapshot.data[index];

                              // for search text
                              if (user['userName'].toString().contains(
                                  _searchController.text.toString())) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: CustomText(
                                    title: '${user['userName']}',
                                  ),
                                  trailing: Text('- ${user['branchName']} -'),
                                  onTap: () async {
                                    // get the room id  then pass it in navigator

                                    var roomId =
                                        await Api.getOrCreateIndividualRoom(
                                            userId: SharedPreferencesService()
                                                .getUserInfo()
                                                .userId,
                                            recievedId: user['id']);
                                    // setState(() =>_isLoading=false);

                                    if (roomId != null && roomId > 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualChat(
                                                    roomId: roomId,
                                                    peerUserId: user['id'],
                                                    peerUserName:
                                                        user['userName'],
                                                  )));
                                    }
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        } else {
                          return CustomText(
                            title: 'لايوجد هناك اي مستخدمين حالياً',
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
        ),
      ),
    );
  }
}
