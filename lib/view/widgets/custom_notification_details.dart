import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomNotificationDetails extends StatelessWidget {
  final String title;
  final Alignment titleAlignment;
  final Color titleColor;
  final String content;
  final Alignment contentAlignment;
  final Color contentColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Function onPressed;
  final String date;
  final double dateSize;
  final Alignment dateAlignment;

  CustomNotificationDetails(
      {this.title = '',
        this.titleAlignment = Alignment.center,
        this.titleColor = Colors.black,
        this.content = '',
        this.contentAlignment,
        this.contentColor = Colors.black,
        this.fontSize,
        this.fontWeight,
        this.onPressed,
        this.date,
        this.dateSize,
        this.dateAlignment
      });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: kPrimaryColor,
        title: CustomText(
          title: title,
          alignment: titleAlignment,
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              CustomText(
                title: content,
                fontSize: fontSize,
                fontWeight: fontWeight,
                alignment: contentAlignment,
                color: contentColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomText(
                  title: date,
                  fontSize: dateSize,
                  alignment: dateAlignment,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            width:MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              IconButton(icon: Icon(Icons.close,color: Colors.white,), onPressed: onPressed)
            ],),
          )
        ],
      ),
    );

  }
}
