import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinder/pages/home.dart'; 
import 'package:pinder/pages/details.dart'; 

void main() {
  runApp(PinderApp());
}

class PinderApp extends StatelessWidget {
  // This widget is the root of your application.
  Route onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/':
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return HomePage();
          }
        );
      
      case '/details':
        final args = settings.arguments as Map<String, dynamic>;
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return DetailsPage(metadata: args['metadata']);
          }
        );
    }

    throw Error();
  }

  Route onUnknownRoute(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
        return Container(
          child: const Text('Something borked!')
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      color: Colors.white,
      textStyle: TextStyle(
        color: Colors.black87
      ),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate
      ],
    );
  }
}