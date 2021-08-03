import 'package:flutter/material.dart';
import 'package:green_book/Utils/SizeConfig.dart';
import 'package:green_book/helper/UIHelper.dart';
import 'package:green_book/screens/Home1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashWait();
    super.initState();
  }

  void splashWait() {
    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home1())));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png',
              height: SizeConfig.safeBlockVertical * 20),
        ],
        // UIHelper.getBottomText()
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 4),
          // padding: EdgeInsets.symmetric(
          //     horizontal: SizeConfig.safeBlockHorizontal * 2),
          child: UIHelper.getBottomText()),
    );
  }
}
