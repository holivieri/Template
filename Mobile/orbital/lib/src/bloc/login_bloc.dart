import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:adminprop_mobile/src/bloc/validators.dart';


class LoginBloc with Validators {


  final _userNameController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get usernameStream    => _userNameController.stream.transform( validateUserName );
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );

  Stream<bool> get formValidStream => 
      Observable.combineLatest2(usernameStream, passwordStream, (e, p) => true );



  // Insertar valores al Stream
  Function(String) get changeUserName    => _userNameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get username    => _userNameController.value;
  String get password => _passwordController.value;

  dispose() {
    _userNameController?.close();
    _passwordController?.close();
  }

}

