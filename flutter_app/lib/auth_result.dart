import 'package:flutter/material.dart';
import 'authentication/auth_data.dart';
import 'utils.dart';

class AuthResult extends StatefulWidget {
  const AuthResult({Key? key}) : super(key: key);

  @override
  State createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<AuthResult> {
  @override
  Widget build(BuildContext context) {
    AuthData authData = ModalRoute.of(context)?.settings.arguments as AuthData;
    final token = authData.accessToken;

    return Scaffold(
        appBar: Utils.getAppBar(context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Utils.coloreEnaip,
                    child: Padding(
                      padding: const EdgeInsets.all(4), // Border radius
                      child: ClipOval(
                          child: Image(
                              image: NetworkImage(authData.profileImgUrl,
                                  scale: 1,
                                  headers: {
                            'Authorization': 'Bearer $token',
                          }))),
                    ),
                  ),
                  Text("User ID: ${authData.userID}"),
                  Text("Nome: ${authData.firstName}"),
                  Text("Cognome: ${authData.lastName}"),
                  Text("Email: ${authData.email}")
                ])))));
  }
}
