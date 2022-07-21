import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "لاتملك حساب ؟ " : "لديكَ حساب مسبقاً ؟ ",
            style: TextStyle(color: kPrimaryColor,fontFamily: 'ElMessiri'),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              login ? "إنشاء حساب" : "تسجيل الدخول",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
              ),
            ),
          )
        ],
      ),
    );
  }
}