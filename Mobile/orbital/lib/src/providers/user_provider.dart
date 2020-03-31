import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:adminprop_mobile/src/preferencias_usuario/preferencias_usuario.dart';

class UserProvider {

  final _prefs = new UserPreferences();
  final storage = new FlutterSecureStorage();
  Future<Map<String, dynamic>> login( String userName, String password) async {

    String platform = "";

    if (Platform.isAndroid) {
      platform = "ANDROID";
    } else if (Platform.isIOS) {
      platform = "IOS";
    }

    final authData = {
      'UserName'   : userName,
      'Password'   : password,
      'Platform'   : platform,
      'TelefonoID' : _prefs.phoneId
    };
    final _url = await storage.read(key: 'url');
    final url  = '$_url/login/authenticate';

    final resp = await http.post(
      url,
      headers: {'Content-Type' : 'application/json'},
      body: json.encode( authData )
    );
    if(resp.statusCode == 401 )  return { 'ok': false, 'mensaje': 'wrong user name or password' };
    
    Map<String, dynamic> decodedResp = json.decode( resp.body );

    if ( decodedResp.containsKey('UserId') ) {
      _prefs.userId = decodedResp['UserId'];
    }

    if ( decodedResp.containsKey('Token') ) {
      
      _prefs.token = decodedResp['Token'];

      return { 'ok': true, 'token': decodedResp['Token'] };
    } else {
      return { 'ok': false, 'mensaje': 'wrong user name or password' };
    }

  }

  Future<bool> resetPassword(String userId) async{
    
    return true;
  }
}