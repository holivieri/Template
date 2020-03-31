import 'package:adminprop_mobile/src/utils/utilities.dart';
import 'package:flutter/material.dart';

import 'package:adminprop_mobile/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:adminprop_mobile/src/providers/menu_provider.dart';



class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Orbital Technologies'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/final-3.png'),
              radius: 25.0,
            ),
          ),
        ],
      ),
      body: _lista(),
    );
  }

  Widget _lista() {


    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot ){
       
        return ListView(
          children: _listItems( snapshot.data, context ),
        );

      },
    );

  }



  List<Widget> _listItems( List<dynamic> data, BuildContext context ) {

    final List<Widget> opciones = [];

    data.forEach( (opt) {
      if(opt['text'] != 'Log Out') {
         final widgetTemp = ListTile(
          title: Text( opt['text'] ),
          leading:  getIcon( opt['icon'] ) ,
          trailing: Icon ( Icons.keyboard_arrow_right, color: Colors.blue ),
          onTap: () {
            Navigator.pushNamed(context, opt['path'] );
          },
        );

        opciones..add( widgetTemp )
                ..add( Divider() );
        }
        else {
            final widgetTemp = ListTile(
                  title: Text( opt['text'], style: TextStyle(color: Colors.red), ),
                  leading:  getIcon( opt['icon'] ) ,
                  trailing: Icon ( Icons.keyboard_arrow_right, color: Colors.red ),
                  onTap: () {
                     final _prefs = new UserPreferences();
                     _prefs.token = null;
                     _prefs.userId = null;
                     
                    Navigator.pushReplacementNamed(context, opt['path'] );
                  },
                );

                opciones..add( widgetTemp )
                        ..add( Divider() );
        }

    });

    return opciones;

  }

}


