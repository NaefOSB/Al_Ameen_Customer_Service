import 'dart:convert';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_chat.dart';
import 'package:al_ameen_customer_service/model/chat.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_chat_bubble.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_send_message_area.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/core/services/api.dart';

class ChatScreen extends StatefulWidget {
  final String
      roleName; // => for the Category role. 5 states :Customer Service,Accounting,Maintenance,Programming or Privacy
  final String
      customerId; // => if the current user is admin or employee it will contain the id of the customer id
  final int roomId;
  final String userName;

  ChatScreen({this.roleName, this.customerId, this.roomId, this.userName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String getRoomName() {
    switch (widget.roleName) {
      case 'Customer Service':
        {
          return 'قسم خدمة العملاء';
        }
      case 'Accounting':
        {
          return 'قسم الحسابات';
        }
      case 'Maintainence':
        {
          return 'الصيانة والدعم الفني';
        }
      case 'Programming':
        {
          return 'قسم البرمجيات';
        }
    }
  }

  TextEditingController _senderController;

  @override
  void initState() {
    _senderController = new TextEditingController();
    super.initState();
  }

  getRoomId() {
    if (SharedPreferencesService().getUserInfo().role == 'Customer') {
      switch (widget.roleName) {
        case 'Customer Service':
          {
            return SharedPreferencesService().getUserInfo().customerService;
          }
        case 'Accounting':
          {
            return SharedPreferencesService().getUserInfo().accounting;
          }
        case 'Maintainence':
          {
            return SharedPreferencesService().getUserInfo().maintenance;
          }
        case 'Programming':
          {
            return SharedPreferencesService().getUserInfo().programming;
          }
      }
    } else {
      // for employess or admin
      return widget.roomId;
    }
  }

  @override
  Widget build(BuildContext context) {
    String prevUserId;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: CustomText(
            title: (SharedPreferencesService().getUserInfo().role != 'Customer')
                ? '${widget.userName}'
                : '${getRoomName()}',
            color: Colors.white,
            alignment: Alignment.center,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: StreamBuilder(
              // if the currentUser is Customer it will take my id ,but if the currentUser is admin or employee it will pass
              // the id of customer in currentUserId
              stream: Api.chatStream(
                  (SharedPreferencesService().getUserInfo().role.toString() ==
                          'Customer')
                      ? SharedPreferencesService().getUserInfo().userId
                      : widget.customerId,
                  getRoomId()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  final chatData = json.decode(snapshot.data);

                  String currentUserId =
                      SharedPreferencesService().getUserInfo().userId;
                  return SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),
                      itemCount: chatData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Chat chat = Chat.fromJson(chatData[index]);
                        final bool isMe = chat.userId == currentUserId;
                        final bool isSameUser = prevUserId == chat.userId;
                        prevUserId = chat.userId;
                        return CustomChatBubble(
                          chat: chat,
                          isMe: isMe,
                          isSameUser: isSameUser,
                          senderName: chat.userName,
                        );
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Text('');
              },
            )),
            CustomSendMessageArea(
              controller: _senderController,
              imageOnPressed: () {},
              sendOnPressed: () {
                setState(() {});

                Api.sendChat(new VM_Chat(
                    ChatId: 0,
                    Message: _senderController.text.toString(),
                    RoomId: getRoomId(),
                    Type: 0,
                    UserId: SharedPreferencesService()
                        .getUserInfo()
                        .userId
                        .toString()));
                _senderController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
