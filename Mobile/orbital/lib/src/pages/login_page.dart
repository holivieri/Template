import 'package:adminprop_mobile/src/providers/user_provider.dart';
import 'package:adminprop_mobile/src/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:adminprop_mobile/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground( context ),
          _loginForm( context ),
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = ProviderBLoc.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('ORBITAL', style: TextStyle(fontSize: 20.0)),
                SizedBox( height: 60.0 ),
                _createUserName( bloc ),
                SizedBox( height: 30.0 ),
                _createPassword( bloc ),
                SizedBox( height: 30.0 ),
                _createButton( bloc )
              ],
            ),
          ),
          SizedBox( height: 100.0 )
        ],
      ),
    );


  }

  Widget _createUserName(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.usernameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),

        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon( Icons.person_outline, color: Colors.blue ),
            labelText: 'UserName',
            errorText: snapshot.error
          ),
          onChanged: bloc.changeUserName,
        ),

      );
      },
    );


  }

  Widget _createPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.blue ),
              labelText: 'Password',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),

        );

      },
    );


  }

  Widget _createButton( LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
            child: Text('Log In'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {

    

     Map info = await userProvider.login(bloc.username, bloc.password);
     if(info['ok'] )
     {
        Navigator.pushReplacementNamed(context, '/');
     } else {
        showAlert(context, 'Wrong user name or password');
     }
    
  }


  Widget _createBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final whiteBackground = Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Colors.blue,
            Colors.lightBlue
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        whiteBackground,
       
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/final-3.png')),
              SizedBox( height: 10.0, width: double.infinity ),
            ],
          ),
        )

      ],
    );

  }

}