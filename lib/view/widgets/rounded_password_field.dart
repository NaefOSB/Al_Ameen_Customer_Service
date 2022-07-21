import 'package:flutter/material.dart';
import 'package:al_ameen_customer_service/view/widgets/text_field_container.dart';
import 'package:al_ameen_customer_service/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final Function validator;
  final String hintText;
  final String textInputAction;
  final Function onFieldSubmitted;

  const RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.textEditingController,
      this.validator,
      this.hintText = '',
      this.textInputAction = 'next',
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textEditingController,
        obscureText: obscureText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        textInputAction: (widget.textInputAction == 'next')
            ? TextInputAction.next
            : TextInputAction.done,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontFamily: 'ElMessiri'),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon((obscureText) ? Icons.visibility_off : Icons.visibility),
            color: kPrimaryColor,
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
                widget.textEditingController.text =
                    widget.textEditingController.text;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
