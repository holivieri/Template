import 'package:adminprop_mobile/src/bloc/combosNotifier.dart';
import 'package:adminprop_mobile/src/providers/user_provider.dart';
import 'package:adminprop_mobile/src/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final comboStatus = Provider.of<CombosNotifier>(context);
     return Scaffold(
                    appBar: AppBar(
                      title: Text('Reset Password'),
                    ),
                    body: Column(
                              children: <Widget>[
               
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: <Widget>[
                                                      Expanded(
                                                             child: RaisedButton(
                                                                  child: Text('RESET'),
                                                                  color: Colors.blue,
                                                                  textColor: Colors.white,
                                                                  shape: StadiumBorder(),
                                                                  onPressed: () => _resetPassword(context, comboStatus.userId),
                                                                ),
                                                      )
                                        ],),
                                      )
                              ],
                            )
              );
  }
  
  void _resetPassword(BuildContext context, String userId) async {
      UserProvider provider = new UserProvider();
      try{


          var result = await provider.resetPassword(userId);
          
          if( result ){
              showAlert(context, 'Se blanqueo la contraseña para el usuario');
          }
          else{
             showAlert(context, 'No se pudo realizar la operacion, comuniquese con AdminProp');
          }
          

      }catch(e){
        showAlert(context, 'No se pudo blanquear la clave. Comuniquese con AdminProp');
      }


  }
}