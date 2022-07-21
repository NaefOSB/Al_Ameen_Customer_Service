import 'package:al_ameen_customer_service/core/services/api.dart';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/login/login_screen.dart';
import 'package:al_ameen_customer_service/view/category/categories.dart';
import 'package:al_ameen_customer_service/view/widgets/already_have_an_account_acheck.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_alert_dialog.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_button.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_input_field.dart';
import 'package:al_ameen_customer_service/view/widgets/rounded_password_field.dart';
import 'package:al_ameen_customer_service/view/widgets/text_field_container.dart';
import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_create_account.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'background.dart';
import 'dropdown_button.dart';

class Body extends StatefulWidget {
  final String userRole;

  Body({this.userRole = 'Customer'});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, String> headers = {};
  bool _isLoading = false;

  // for userRoles => for admin control
  Map<String, dynamic> roles = {
    "البرمجة": "Programming",
    "خدمة العملاء": "Customer Service",
    "المحاسبة": "Accounting",
    "الصيانة": "Maintainence",
    "عميل": "Customer",
    "مدير": "ADMIN"
  };
  String selectedRole = 'Customer';
  String userRoleName = 'إختر رتبة الحساب';
  bool _isRoleSelected = false;

  // fields controllers
  TextEditingController _fullNameController;
  TextEditingController _phoneNumberController;
  TextEditingController _addressController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  // variable for fields
  String branchName = 'إختار فرعك';
  bool _isBranchSelected = false;
  List branch = [];
  var selectedBranchId;
  var groupValue;
  var groupValue2;
  bool isStretchedDropDown = false;
  bool isStretchedDropDownForAdmin = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void getBranches() async {
    Api api = new Api();
    branch = await api.getAllBranches() as List;
  }

  @override
  void initState() {
    getBranches();
    _fullNameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _addressController = new TextEditingController();
    _confirmPasswordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Background(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri',
                        fontSize: 25),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    'assets/images/signUp.png',
                    color: kPrimaryColor,
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "الأسم الكامل",
                    controller: _fullNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء إدخال أسمك الكامل';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "رقم الهاتف",
                    icon: Icons.phone,
                    controller: _phoneNumberController,
                    keyboardType: 'phone',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء إدخال رقم هاتفك للدخول به';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),

                  TextFieldContainer(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isStretchedDropDown = !isStretchedDropDown;
                          if (branch.length < 1) {
                            getBranches();
                          }
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(27))),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: double.infinity,


                                          constraints: BoxConstraints(
                                            minHeight: 45,
                                            minWidth: double.infinity,
                                          ),
                                          alignment: Alignment.center,
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.location_city,
                                                  color: kPrimaryColor,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      child: Column(
                                                        children: [
                                                          CustomText(
                                                            title: branchName,
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                          Visibility(
                                                              visible:
                                                                  _isBranchSelected,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            5.0),
                                                                child:
                                                                    CustomText(
                                                                  title:
                                                                      'الرجاء إختيار الفرع',
                                                                  color: Colors
                                                                      .red
                                                                      .shade700,
                                                                  fontSize:
                                                                      11.0,
                                                                ),
                                                              )),
                                                        ],
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Icon(
                                                      isStretchedDropDown
                                                          ? Icons.arrow_upward
                                                          : Icons
                                                              .arrow_downward,
                                                      color: kPrimaryColor),
                                                )
                                              ],
                                            ),
                                          )),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ExpandedSection(
                                          expand: isStretchedDropDown,
                                          height: 100,
                                          child: ListView.builder(
                                            itemCount: branch.length,
                                            padding: EdgeInsets.all(0),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return RadioListTile(
                                                  title: CustomText(
                                                    title: branch[index]['name']
                                                        .toString(),
                                                    color: Colors.black87,
                                                  ),
                                                  value: branch[index]['id'],
                                                  groupValue: groupValue,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      groupValue = val;
                                                      branchName =
                                                          branch[index]['name'];
                                                      selectedBranchId =
                                                          branch[index]['id'];
                                                      isStretchedDropDown =
                                                          !isStretchedDropDown;
                                                    });
                                                  });
                                            },
                                          ),

                                          // ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // for admin only
                  (widget.userRole == "ADMIN")
                      ? TextFieldContainer(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isStretchedDropDownForAdmin =
                                    !isStretchedDropDownForAdmin;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            // border: Border.all(color: Color(0xffbbbbbb)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(27))),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: double.infinity,

                                                // padding: EdgeInsets.only(right: 10),

                                                constraints: BoxConstraints(
                                                  minHeight: 45,
                                                  minWidth: double.infinity,
                                                ),
                                                alignment: Alignment.center,
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                        Icons.location_city,
                                                        color: kPrimaryColor,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              children: [
                                                                CustomText(
                                                                  title:
                                                                      userRoleName,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                ),
                                                                Visibility(
                                                                    visible:
                                                                        _isRoleSelected,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              5.0),
                                                                      child:
                                                                          CustomText(
                                                                        title:
                                                                            'الرجاء إختيار الرتبة',
                                                                        color: Colors
                                                                            .red
                                                                            .shade700,
                                                                        fontSize:
                                                                            11.0,
                                                                      ),
                                                                    )),
                                                              ],
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Icon(
                                                            isStretchedDropDownForAdmin
                                                                ? Icons
                                                                    .arrow_upward
                                                                : Icons
                                                                    .arrow_downward,
                                                            color:
                                                                kPrimaryColor),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: ExpandedSection(
                                                expand:
                                                    isStretchedDropDownForAdmin,
                                                height: 100,
                                                child: ListView.builder(
                                                  itemCount: roles.length,
                                                  padding: EdgeInsets.all(0),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return RadioListTile(
                                                        title: CustomText(
                                                          title: roles.keys
                                                              .toList()[index]
                                                              .toString(),
                                                          color: Colors.black87,
                                                        ),
                                                        value: roles.values
                                                            .toList()[index],
                                                        groupValue: groupValue2,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            groupValue2 = val;
                                                            selectedRole = roles
                                                                    .values
                                                                    .toList()[
                                                                index];
                                                            userRoleName = roles
                                                                    .keys
                                                                    .toList()[
                                                                index];
                                                            isStretchedDropDownForAdmin =
                                                                !isStretchedDropDownForAdmin;
                                                          });
                                                        });
                                                  },
                                                ),

                                                // ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),

                  RoundedInputField(
                    hintText: "العنوان",
                    icon: Icons.location_on,
                    controller: _addressController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء إدخال عنوانك';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    hintText: 'كلمة المرور',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      } else if (value.toString().length <= 6) {
                        return 'الرجاء إدخال كلمة مرور أكبر من 6 رموز!!';
                      }
                      return null;
                    },
                    textEditingController: _passwordController,
                  ),
                  RoundedPasswordField(
                    hintText: 'تأكيد كلمة المرور',
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {
                      validationProcess();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء تأكيد كلمة المرور';
                      } else if (value.toString() != _passwordController.text) {
                        return 'كلمة المرور المدخلة غير مطابقة !!';
                      }
                      return null;
                    },
                    textInputAction: 'done',
                    textEditingController: _confirmPasswordController,
                  ),
                  // Registration Button
                  RoundedButton(
                    text: "إنشاء حساب",
                    fontSize: 15,
                    press: () => validationProcess(),
                  ),

                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validationProcess() {
    // we have 2 kind of creation
    // 1- for any user
    // 2- for admin control

    // for admin control
    if (_formKey.currentState.validate() &&
        (branchName != 'إختار فرعك') &&
        widget.userRole == 'ADMIN') {
      //  for if the role does not selected
      if (userRoleName == 'إختر رتبة الحساب') {
        setState(() {
          _isRoleSelected = true;
        });
      } else {
        creationProcess();
      }
    } else if (_formKey.currentState.validate() &&
        (branchName != 'إختار فرعك') &&
        widget.userRole == 'Customer') {
      // for the customer addition
      creationProcess();
    }
    // to show the error on branch dropdown
    if ((branchName == 'إختار فرعك')) {
      setState(() {
        _isBranchSelected = true;
      });
    }
  }

  void creationProcess() async {
    try {
      //  for create user

      // to collect user info to send it for create an account
      VM_CreateAccount user = new VM_CreateAccount(
          Name: _fullNameController.text,
          PhoneNumber: _phoneNumberController.text,
          BranchID: selectedBranchId,
          Address: _addressController.text,
          Password: _passwordController.text);

      Api api = new Api();
      setState(() => _isLoading = true);
      // for create an account
      var userInfo = await api.createUser(user, selectedRole.toString());

      // to check if the user is created or not
      if (userInfo.toString() == 'Exist') {
        // when the user is exist
        showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
                  title: 'الحساب موجود مسبقاً',
                  content: 'الحساب موجود مسبقاً الرجاء ادخال معلومات جديدة!!',
                  firstButtonText: 'موافق',
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                ));
      } else if (userInfo.toString() == 'Error') {
        //  when something went wrong
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
          if (widget.userRole != "ADMIN") {
            // to prevent store user info if the person who create this account is the admin himself
            await SharedPreferencesService().setUserInfo(userInfo);
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Categories()),
              (route) => false);
        }
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }
}
