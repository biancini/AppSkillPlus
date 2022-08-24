import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'utils.dart';
import 'app_scale.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Widget build(BuildContext context) {
    AppScale scale = AppScale(context);
    final double iconWidth = scale.ofHeight(0.0245);

    return Scaffold(
      appBar: Utils.getAppBar(context, canGoBack: false),
      body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Container(
                  color: HexColor('#f5f5f5'),
                  width: scale.ofWidth(1),
                  padding: EdgeInsets.fromLTRB(
                      0, scale.ofHeight(0.027), 0, scale.ofHeight(0.027)),
                  child: Column(children: [
                    Utils.getButton(
                        text: 'Sign up',
                        color: Colors.green,
                        textColor: Colors.black,
                        icon: Image.asset('assets/enaip.png', width: iconWidth),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/ad-auth')),
                  ])))),
    );
  }
}
