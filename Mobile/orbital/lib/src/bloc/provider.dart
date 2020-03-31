import 'package:flutter/material.dart';
import 'package:adminprop_mobile/src/bloc/login_bloc.dart';
export 'package:adminprop_mobile/src/bloc/login_bloc.dart';


class ProviderBLoc extends InheritedWidget {

  static ProviderBLoc _instance;

  factory ProviderBLoc({ Key key, Widget child }) {

    if ( _instance == null ) {
      _instance = new ProviderBLoc._internal(key: key, child: child );
    }

    return _instance;

  }

  ProviderBLoc._internal({ Key key, Widget child })
    : super(key: key, child: child );


  final loginBloc = LoginBloc();


 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBLoc>().loginBloc;
  }

}