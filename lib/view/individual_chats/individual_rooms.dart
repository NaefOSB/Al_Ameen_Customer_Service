import 'dart:math';
import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/individual_chats/individual_chat.dart';
import 'package:al_ameen_customer_service/view/individual_chats/users.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/constants.dart';

class IndividualRooms extends StatefulWidget {
  @override
  _IndividualRoomsState createState() => _IndividualRoomsState();
}

class _IndividualRoomsState extends State<IndividualRooms> {
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade500,
        body: Column(
          children: [
            // ---------------- Header -----------------------

            Container(
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
                    suffixIcon: IconButton(icon: Icon(Icons.clear),onPressed: (){
                      _searchController.clear();
                    },),
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: 'ابحث عن دردشة..',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'ElMessiri')),
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
                    future: Api.getAllIndividualRoom(
                        SharedPreferencesService().getUserInfo().userId),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var room = snapshot.data[index];

                            // for search text
                            if (room['peerUserName']
                                    .toString()
                                    .contains(_searchController.text) ||
                                room['branchName']
                                    .toString()
                                    .contains(_searchController.text)) {
                              return ListTile(
                                title: CustomText(
                                  title: '${room['peerUserName']}',
                                  fontSize: 18.0,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Text('- ${room['branchName']} -'),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15.0),
                                onTap: () {
                                  NavigationService.to(
                                      context: context,
                                      to: IndividualChat(
                                        peerUserName: room['peerUserName'],
                                        peerUserId: room['peerUserId'],
                                        roomId: room['roomId'],
                                      ));
                                },
                              );
                            } else {
                              return Container();
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
        floatingActionButton: (SharedPreferencesService().getUserInfo().role == 'ADMIN')? FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Users())),
          child: Icon(Icons.group),
        ):null,
      ),
    );
  }
}
