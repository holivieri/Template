import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final _icons = <String, IconData>{
  'input'         : Icons.input,
  'logoutIcon'        : Icons.exit_to_app,
  'resetIcon'         : Icons.restore_page,
};

void showAlert(BuildContext context, String mensaje) {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(mensaje),
              Image(image: AssetImage('assets/final-3.png'), height: 100.0, width: 100.0,)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );

      }
    );
}



String moneyFormat(double amount){

  String text =  NumberFormat.simpleCurrency(locale: 'eu', name: 'ARS').format(amount).toString();
  text = text.replaceAll('\$', '');
  return '\$ ' + text;

}

String moneyFormatNonCurrency(double amount){

  String text =  NumberFormat.simpleCurrency(locale: 'eu', name: 'ARS').format(amount).toString();
  text = text.replaceAll('\$', '');
  return text;

}


openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'unable to navigate to $url';
  }
}





Icon getIcon( String iconName ) {

  return Icon( _icons[iconName], color: Colors.blue );
  
}