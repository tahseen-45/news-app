import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utils/routes/routes_name.dart';
import 'package:newsapp/view/category_screen.dart';
import 'package:newsapp/view/detail_screen.dart';
import 'package:newsapp/view/home_screen.dart';
import 'package:newsapp/view/login_screen.dart';
import 'package:newsapp/view/splash_screen.dart';


class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
       return MaterialPageRoute(builder: (context) => SplashScreen(),);
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen(),);
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case RoutesName.category:
        return MaterialPageRoute(builder: (context) => CategoryScreen(),);
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(child: Text("No Route Found")),
          );
        },);
    }
  }
}