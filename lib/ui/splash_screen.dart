import 'package:flutter/material.dart';
import 'forms.dart';
import 'logo_widget.dart';
import 'screen_util.dart';
import 'login_component.dart';
import 'routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
  void initState() {
    // TODO: implement initState
        super.initState();
        Future.delayed(Duration(milliseconds: 2000), () {
            AppRoutes.makeFirst(context, FormDemo());
        });
  }

  @override
  Widget build(BuildContext context) {
      Constant.setScreenAwareConstant(context);

    return SafeArea(
      child: Scaffold(
          body: Stack(
              children: <Widget>[
                  BackgroundImageWidget(
                      color: Colors.white,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Center(
                              child: AppLogoWidget() ,
                          )
                      ],
                  )
              ],
          ),
      ),
    );
  }
}
