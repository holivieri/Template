import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  
  get userId {
    return _prefs.getString('userId') ?? '';
  }

  set userId( String value ) {
    _prefs.setString('userId', value);
  }

  // GET y SET del AdministradorId
  get phoneId {
    return _prefs.getString('phoneId') ?? '';
  }

  set phoneId( String value ) {
    _prefs.setString('phoneId', value);
  }

}

