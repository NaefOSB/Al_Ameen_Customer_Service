import 'package:flutter/material.dart';

class CustomSendMessageArea extends StatelessWidget {
  final TextEditingController controller;
  final Function imageOnPressed;
  final Function sendOnPressed;

  CustomSendMessageArea(
      {this.controller, this.imageOnPressed, this.sendOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: imageOnPressed,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontFamily: 'ElMessiri'),
              decoration: InputDecoration.collapsed(
                hintText: 'أرسل رسالة ..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: sendOnPressed,
          ),
        ],
      ),
    );
  }
}
