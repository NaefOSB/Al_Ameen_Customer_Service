import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Alignment titleAlignment;
  final Color titleColor;
  final String content;
  final Alignment contentAlignment;
  final Color contentColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Function onPressed1;
  final Function onPressed2;
  final String firstButtonText;
  final String secondButtonText;
  final bool hasSecondButton;

  CustomAlertDialog(
      {this.title = '',
      this.titleAlignment = Alignment.center,
      this.titleColor = Colors.black,
      this.content = '',
      this.contentAlignment,
      this.contentColor = Colors.black,
      this.fontSize,
      this.fontWeight,
      this.onPressed1,
      this.onPressed2,
      this.firstButtonText = 'إلغاء',
      this.secondButtonText = 'موافق',
      this.hasSecondButton = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: CustomText(
          title: title,
          alignment: titleAlignment,
          color: titleColor,
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
            ],
          ),
        ),
        actions: [
          FlatButton(
              onPressed: onPressed1,
              child: CustomText(
                title: firstButtonText,
                color: kPrimaryColor,
                fontSize: 12.0,
              )),
          (hasSecondButton)
              ? FlatButton(
                  onPressed: onPressed2,
                  child: CustomText(
                    title: secondButtonText,
                    color: kPrimaryColor,
                    fontSize: 12.0,
                  ))
              : Container(),
        ],
      ),
    );

  }
}
