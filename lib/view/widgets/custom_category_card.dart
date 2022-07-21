import 'package:flutter/material.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  CustomCategoryCard({this.title = '', this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.white,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue.shade500,
                        Colors.lightBlue.shade500
                      ],
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '$title',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 36,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
