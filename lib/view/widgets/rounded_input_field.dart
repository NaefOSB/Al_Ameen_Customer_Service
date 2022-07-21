import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/view/widgets/text_field_container.dart';
import 'package:al_ameen_customer_service/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String keyboardType;
  final TextEditingController controller;
  final Function validator;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller,
      this.keyboardType = 'text',
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType: getKeyboardType(keyboardType),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'ElMessiri'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  TextInputType getKeyboardType(type) {
    switch (type) {
      case 'text':
        return TextInputType.text;
      case 'phone':
        return TextInputType.phone;
      case 'email':
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }
}
