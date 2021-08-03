import 'package:flutter/material.dart';
import 'package:green_book/Utils/SizeConfig.dart';

class UIHelper {
  static Widget getBottomText() {
    return Text('CandidateID: deepak_deepak.yadav270300@gmail.com',
        textAlign: TextAlign.center);
  }

  static Widget getAppBarView() {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        height: SizeConfig.blockSizeVertical * 7,
      ),
      backgroundColor: Colors.white24,
      elevation: 0.0,
    );
  }
}
