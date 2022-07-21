import 'dart:math';

import 'package:flutter/material.dart';

class CustomChatTile extends StatelessWidget {
  final String userName, msg, date;
  final bool seen;
  final Function onTap;

  CustomChatTile({this.userName, this.msg, this.date, this.seen,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
              radius: 28.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          userName,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ElMessiri'),
                        ),
                      ),
                      Text(date),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            msg,
                            style: TextStyle(fontFamily: 'ElMessiri'),
                          )),
                      if (seen)
                        Icon(
                          Icons.circle,
                          size: 18.0,
                          color: Colors.green,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
