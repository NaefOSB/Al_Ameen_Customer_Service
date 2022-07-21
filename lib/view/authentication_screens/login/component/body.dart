import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_sign_in.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/login/component/background.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/signup_screen.dart';
import 'package:al_ameen_customer_service/view/widgets/already_have_an_account_acheck.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_alert_dialog.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_button.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_input_field.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _phoneNumberController = new TextEditingController();

  TextEditingController _passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: size.width / 4.5),
                  child: Text(
                    "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                        fontSize: 22,
                        color: Colors.lightBlue.shade500),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  'assets/images/login-2.png',
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                // inputs
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: RoundedInputField(
                    hintText: "أكتب رقمك",
                    icon: Icons.phone,
                    controller: _phoneNumberController,
                    keyboardType: 'phone',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'الرجاء إدخال رقم جوالك للدخول';
                      }
                      return null;
                    },
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: RoundedPasswordField(
                    hintText: "كلمة المرور",
                    textEditingController: _passwordController,
                    onChanged: (value) {},
                    textInputAction: 'done',
                    onFieldSubmitted: (value) {
                      loginProcess();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      }
                    },
                  ),
                ),
                RoundedButton(
                  text: "تسجيل الدخول",
                  press: () => loginProcess(),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen(
                            userRole: 'Customer',
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginProcess() async {
    try {
      if (_formKey.currentState.validate()) {
        VM_SignIn signInfo = new VM_SignIn(
            phoneNumber: _phoneNumberController.text,
            password: _passwordController.text);
        Api api = new Api();
        setState(() => _isLoading = true);
        var userInfo = await api.signIn(signInfo);

        if (userInfo.toString() == 'WrongEmailOrPassword') {
          setState(() => _isLoading = false);
          // when the phone number or password is wrong
          showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                    title: 'خطأ في المعلومات',
                    content:
                        'المعلومات الذي ادخلتها خاطئه الرجاء ادخال معلومات صحيحة!!',
                    firstButtonText: 'موافق',
                    onPressed1: () {
                      Navigator.pop(context);
                    },
                  ));
        } else if (userInfo.toString() == 'Error') {
          //  when something went wrong
          setState(() => _isLoading = false);
          showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                    title: 'حدث خطأ',
                    content: 'حدث خطأ في الاتصال الرجاء المحاولة مرة أخرى!!',
                    firstButtonText: 'موافق',
                    onPressed1: () {
                      Navigator.pop(context);
                    },
                  ));
        } else {
          if (userInfo['userId'] != null &&
              userInfo['isAuthenticated'] &&
              userInfo['roles'][0] != null) {
            //  if everything is success
            await SharedPreferencesService().setUserInfo(userInfo);
            NavigationService.navigateProcessOffAll(
                context: context, role: userInfo['roles'][0].toString());
          }
        }
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }
}
