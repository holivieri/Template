import 'package:flutter/cupertino.dart';

class CombosNotifier with ChangeNotifier
{

    String _country = '';
    String _userId = '';

    String get userId => _userId;

    set userId (String value){
      _userId = value;
    }

    //Selected Country
    String get country => _country;
    
    set country (String value){
      _country = value;
      notifyListeners();
    }

}