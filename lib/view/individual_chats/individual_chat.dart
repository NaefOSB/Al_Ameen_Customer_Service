import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/model/individual_chat.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_chat_bubble.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_send_message_area.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class IndividualChat extends StatefulWidget {
  final String peerUserId;
  final int roomId;
  final String peerUserName;

  IndividualChat({this.peerUserId, this.roomId, this.peerUserName});

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  TextEditingController _senderController;

  @override
  void initState() {
    _senderController = new TextEditingController();
    super.initState();
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
            title: '${widget.peerUserName}',
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
              stream: Api.getIndividualMessagedStream(roomId: widget.roomId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  final chatData = snapshot.data;
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
                        final IndividualChatModel chat =
                            IndividualChatModel.fromJson(chatData[index]);
                        final bool isMe = chat.myUserId == currentUserId;
                        final bool isSameUser = prevUserId == chat.myUserId;
                        prevUserId = chat.myUserId;
                        return CustomChatBubble(
                          chat: chat,
                          isMe: isMe,
                          isSameUser: isSameUser,
                          senderName: (isMe)
                              ? SharedPreferencesService()
                                  .getUserInfo()
                                  .userName
                              : widget.peerUserName,
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
                if (_senderController.text.isNotEmpty) {
                  Api.sendIndividualMessage(
                      roomId: widget.roomId,
                      Message: _senderController.text,
                      senderId:
                          SharedPreferencesService().getUserInfo().userId);
                }
                _senderController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
