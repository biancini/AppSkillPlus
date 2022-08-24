import 'authentication/auth.dart';
import 'authentication/debug.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'authentication/auth_data.dart';
import 'authentication/ad.dart';

import 'utils.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key, required this.thirdParty}) : super(key: key);

  final String thirdParty;
  final Debug _debug = Debug(prefix: 'In AuthPage ->');

  @override
  Widget build(BuildContext context) {
    WebView? authenticate = _getThirdPartyAuth(context);

    return Scaffold(
      appBar: Utils.getAppBar(context),
      body: authenticate,
    );
  }

  WebView? _getThirdPartyAuth(context) {
    done(AuthData authData) {
      _debug.info('Authentication Complete!');
      _debug.info('Data Gathered During Authentication: $authData');

      Navigator.pushReplacementNamed(context, '/complete-profile',
          arguments: authData);
    }

    var adAuth = ADAuth();

    List<Auth> allProviders = [adAuth];

    for (var provider in allProviders) {
      provider.debug = true;
    }

    switch (thirdParty) {
      case 'AD':
        return adAuth.simpleAuth.authenticate(
            clientID: '9be4ad30-b36c-4d5f-8995-c513d830f69d',
            redirectUri: 'msauth.com.example.flutterApp://auth',
            scope: 'openid,profile,offline_access,User.read',
            state: 'adAuth',
            onDone: done);

      default:
        return null;
    }
  }
}
