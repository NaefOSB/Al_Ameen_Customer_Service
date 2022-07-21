import 'package:al_ameen_customer_service/core/services/date_service.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final chat;
  final bool isMe, isSameUser;
  final String senderName;

  CustomChatBubble({this.chat, this.isMe, this.isSameUser, this.senderName});

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${chat.message}',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'ElMessiri'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        // Time
                        '${DateService.getDateString(DateTime.parse(chat.date.toString()))}',
                        style: TextStyle(fontSize: 10.0, color: Colors.white)),
                  ],
                ))),
          ),
        ],
      );
    } else {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 3),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // name
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        senderName,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    // message

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 15, left: 10),
                      child: Text(
                        chat.message,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'ElMessiri',
                            fontSize: 16),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      left: 1,
                      child: Text(
                        //time
                        '${DateService.getDateString(DateTime.parse(chat.date.toString()))}',
                        style: TextStyle(
                            fontSize: 10.0, color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
