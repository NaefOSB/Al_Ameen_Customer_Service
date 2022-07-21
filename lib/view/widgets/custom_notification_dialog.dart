import 'package:al_ameen_customer_service/constants.dart';
import 'package:al_ameen_customer_service/view/authentication_screens/regestration/component/dropdown_button.dart';
import 'package:al_ameen_customer_service/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomNotificationDialog extends StatefulWidget {
  final String title;
  final TextEditingController titleController;
  final TextEditingController contentController;

  CustomNotificationDialog(
      {this.title, this.titleController, this.contentController});

  @override
  _CustomNotificationDialogState createState() =>
      _CustomNotificationDialogState();
}

class _CustomNotificationDialogState extends State<CustomNotificationDialog> {
  String notificationType = 'نوع الإرسال';

  bool isStrechedDropDown = false;

  List notificationTypeList = [
    'موظفيني',
    'عملائي',
    'الجميع',
    'كل مستخدمي النظام'
  ];
  int selectedTypeIndex;

  int groupValue;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: CustomText(
          title: widget.title,
          alignment: Alignment.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextFormField(
                controller: widget.titleController,
                decoration: InputDecoration(
                    hintText: 'عنوان الأشعار',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]))),
              ),
              SizedBox(
                height: 10.0,
              ),

              // for type of notification
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStrechedDropDown = !isStrechedDropDown;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              // padding: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffbbbbbb)),
                                // borderRadius: BorderRadius.all(Radius.circular(27))
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      // height: 45,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          right: 10, top: 5.0, bottom: 5.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: (isStrechedDropDown)
                                                ? Color(0xffbbbbbb)
                                                : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      constraints: BoxConstraints(
                                        minHeight: 45,
                                        minWidth: double.infinity,
                                      ),
                                      alignment: Alignment.center,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: Center(
                                                  child: Text(
                                                    notificationType,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Icon(
                                                  isStrechedDropDown
                                                      ? Icons.arrow_upward
                                                      : Icons.arrow_downward,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                      )),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ExpandedSection(
                                      expand: isStrechedDropDown,
                                      height: 100,
                                      child: ListView.builder(
                                        itemCount: notificationTypeList.length,
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return RadioListTile(
                                              title: Text(
                                                  '${notificationTypeList[index]}'),
                                              value: index,
                                              groupValue: groupValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  groupValue = val;
                                                  notificationType =
                                                      notificationTypeList[
                                                          index];
                                                  selectedTypeIndex = index;

                                                  isStrechedDropDown =
                                                      !isStrechedDropDown;
                                                });
                                              });
                                        },
                                      ),
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

              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: widget.contentController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'محتورى الأشعار',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]))),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                    onPressed: () => Navigator.pop(context, 'cancel'),
                    child: CustomText(
                      title: 'إلغاء',
                      color: kPrimaryColor,
                      fontSize: 15.0,
                    )),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  onPressed: () => Navigator.pop(context, '$selectedTypeIndex'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return showDialog(
    //     context: context,
    //     builder: (context) {
    //
    //     });
  }
}
