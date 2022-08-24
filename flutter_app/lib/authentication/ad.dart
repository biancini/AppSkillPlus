import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_data.dart';
import 'debug.dart';
import 'simple_auth.dart';
import 'auth.dart';
import 'oauth.dart';

/// Enables Aure AD [OAuth] authentication
class ADAuth extends Auth {
  final baseUrl = 'https://login.microsoftonline.com/common/oauth2/authorize';
  final responseType = 'code';
  final Debug _debug = Debug(prefix: 'In ADAuth ->');

  ADAuth() {
    simpleAuth = SimpleAuth(
        baseUrl: baseUrl,
        responseType: responseType,

        /// Sends a request to the user profile api
        /// endpoint. Returns an AuthData object.
        getAuthData: (Map<String, String> oauthData) async {
          if (debugMode) _debug.info('OAuth Data: $oauthData');
          final Uri tokenUrl = Uri.parse(
              'https://login.microsoftonline.com/organizations/oauth2/v2.0/token');

          Map<String, String> headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
          };

          String bodyString = Uri(queryParameters: {
            'client_id': oauthData[OAuth.CLIENT_ID_KEY],
            'scope': 'https://graph.microsoft.com/.default',
            'code': oauthData[OAuth.CODE_KEY],
            'redirect_uri': oauthData[OAuth.REDIRECT_URI_KEY],
            'grant_type': 'authorization_code'
          }).query;

          final http.Response tokenResponse =
              await http.post(tokenUrl, headers: headers, body: bodyString);

          final Map<String, dynamic> tokenJson =
              json.decode(tokenResponse.body);
          if (debugMode) _debug.info('Returned Token Json: $tokenJson');

          oauthData[OAuth.TOKEN_KEY] = tokenJson['access_token'];

          final String token = oauthData[OAuth.TOKEN_KEY]!;
          if (debugMode) _debug.info('OAuth token: $token');

          // User profile API endpoint.
          const String baseProfileUrlString =
              'https://graph.microsoft.com/v1.0/me';
          final Uri profileUrl = Uri.parse(baseProfileUrlString);

          final http.Response profileResponse =
              await http.get(profileUrl, headers: {
            'Authorization': 'Bearer $token',
          });
          final Map<String, dynamic> profileJson =
              json.decode(profileResponse.body);
          if (debugMode) _debug.info('Returned Profile Json: $profileJson');

          return authData(profileJson, oauthData);
        });
  }

  /// This function combines information
  /// from the user [json] and auth response [data]
  /// to build an [AuthData] object.
  @override
  AuthData authData(Map<String, dynamic> json, Map<String, String> data) {
    const String profileImgUrl =
        "https://graph.microsoft.com/v1.0/me/photo/\$value";

    return AuthData(
        clientID: data['clientID']!,
        accessToken: data[OAuth.TOKEN_KEY]!,
        userID: json['userPrincipalName'] as String,
        firstName: json['givenName'] as String,
        lastName: json['surname'] as String,
        email: json['mail'] as String,
        profileImgUrl: profileImgUrl,
        response: data,
        userJson: json);
  }
}
