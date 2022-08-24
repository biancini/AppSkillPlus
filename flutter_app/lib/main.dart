import 'package:flutter/material.dart';

import 'auth_page.dart';
import 'registration.dart';
import 'auth_result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppSkill+',
        theme: ThemeData(
          primaryColor: Colors.white,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const RegistrationPage(),
          '/complete-profile': (BuildContext context) => const AuthResult(),
          '/ad-auth': (BuildContext context) => AuthPage(thirdParty: 'AD'),
        });
  }
}
