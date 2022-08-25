import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/custom_button.dart';
import 'app_scale.dart';

class Utils {
  static const Color coloreEnaip = Color.fromARGB(255, 4, 116, 59);

  static void saveLoginData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authData', data);
  }

  static Future<String?> loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authData');
  }

  static getButton(
      {required String text,
      required VoidCallback onPressed,
      double width: 0.75,
      double height: 0.055,
      Color? color,
      Color? textColor,
      Widget? icon}) {
    return CustomButton(
        text: text,
        onPressed: onPressed,
        width: width,
        height: height,
        color: color,
        textColor: textColor,
        icon: icon);
  }

  static getAppBar(BuildContext context, {bool canGoBack = true}) {
    AppScale scale = AppScale(context);

    return AppBar(
      title: const Text('AppSkill+'),
      toolbarHeight: scale.ofHeight(0.076),
      leading: canGoBack
          ? IconButton(
              icon: Icon(Icons.arrow_back, size: scale.ofHeight(0.033)),
              onPressed: () => Navigator.pop(context))
          : null,
      // elevation: 0,
      centerTitle: true,
    );
  }
}
