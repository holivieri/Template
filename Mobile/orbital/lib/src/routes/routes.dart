import 'package:flutter/material.dart';

import 'package:adminprop_mobile/src/pages/documentos_page.dart';
import 'package:adminprop_mobile/src/pages/home_page.dart';
import 'package:adminprop_mobile/src/pages/login_page.dart';
import 'package:adminprop_mobile/src/pages/resetpassword_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
      '/'      : ( BuildContext context ) => HomePage(),
      'documentos' : ( BuildContext context ) => DocumentosPage(),
      'login' : (BuildContext context ) => LoginPage(),
      'logout' : (BuildContext context ) => LoginPage(),
       'resetpassword' : (BuildContext context ) => ResetPassword(),
  };
}