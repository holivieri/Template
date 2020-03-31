import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:adminprop_mobile/src/bloc/combosNotifier.dart';
import 'package:adminprop_mobile/src/bloc/provider.dart';
import 'package:adminprop_mobile/src/pages/home_page.dart';
import 'package:adminprop_mobile/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:adminprop_mobile/src/routes/routes.dart';

 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
    await prefs.initPrefs();
  
  final storage = new FlutterSecureStorage();

  //la borro y la vuelvo a crear,
  //esto evita una excepcion si se hizo un restore desde Google Drive y
  //sirve por si cambiamos la url en una nueva version
  
  try {
    await storage.delete(key: 'url');
    await storage.write(key: 'url', value: 'http://adminprop.net:8081/api');
  }catch(e){
    
  }

  runApp(MyApp());
} 
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

 
  @override
  void initState() { 
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    
    final prefs = new UserPreferences();

    return ChangeNotifierProvider<CombosNotifier>(
        create: (context) => CombosNotifier(),
        child: ProviderBLoc(
                  child: MaterialApp(
                  title: 'ORBITAL TECHNOLOGIES',
                  theme: ThemeData(
                    primaryColor: Color.fromRGBO(14, 126, 192, 1.0),
                     textTheme: Theme.of(context).textTheme.apply(
                                      fontFamily: 'Poppins',
                                      bodyColor: Color.fromRGBO(64, 64, 64, 1.0),
                                      displayColor: Color.fromRGBO(64, 64, 64, 1.0)) 
                  ),
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('es', 'AR'),
                  ],
                  //  home: HomePage(),
                  initialRoute: (prefs.token == '' || prefs.userId == '' ? 'login' : '/' ), 
                  routes: getApplicationRoutes(),
                  onGenerateRoute: ( RouteSettings settings ){

                    return MaterialPageRoute(
                      builder: ( BuildContext context ) => HomePage()
                    );
                  },
                ), 
        ),
    );
  }

}


