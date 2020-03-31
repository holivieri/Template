import 'package:flutter/material.dart';

class DocumentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                      title: Text('Documentos'),
                    ),
            body:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                      SizedBox(height: 10.0),
                              ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: FlatButton(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Center(child: Row(children: <Widget>[
                                                        Icon(Icons.list),
                                                        Text('RECIBOS DE COBRO'),
                                                      ]
                                                      ),
                                                      )
                                                    ],
                                                  ),
                                                  color: Colors.lightGreen,
                                                  textColor: Colors.white,
                                                  onPressed: () => Navigator.pushNamed(context, 'recibos'),
                                                ),
                           ),
                        SizedBox(height: 10.0),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FlatButton(
                                    padding: EdgeInsets.all(20.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.book),
                                        Text('DOCUMENTOS'),
                                      ],
                                    ),
                                    color: Colors.lightGreen,
                                    textColor: Colors.white,
                                    onPressed: () => Navigator.pushNamed(context, 'listadoDocumentos'),
                                  ),
                        ),
                        SizedBox(height: 10.0),
              ],
      ),
            ),
    );
  }
}