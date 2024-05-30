import 'package:flutter/material.dart';
import 'package:memora/features/Authentication/presentation/pages/auth.dart';
import 'package:memora/features/Details/presentation/pages/Details.dart';
import 'package:memora/features/Home/presentation/pages/home.dart';
import 'package:memora/features/Login/presentation/pages/login.dart';
import 'package:memora/features/News/presentation/pages/news.dart';
import 'package:memora/features/detection/presentation/pages/detection.dart';
import 'package:memora/features/signUp/presentation/pages/signUp.dart';

class AppRoutesName {
  static const String auth = "/";
  static const String news = "news";
  static const String signUp = "signup";
  static const String details = "details";
  static const String login = "login";
  static const String home = "home";
  static const String newsDetails = "newsDetails";
  static const String detection = "Detection";
}

class AppRouting{
   static Route onGenerate(RouteSettings settings){
     switch (settings.name) {
      case AppRoutesName.auth:
        return MaterialPageRoute(
          builder: (context) => Auth(),
        );
      case AppRoutesName.news:
        return MaterialPageRoute(
          builder: (context) => News(),
        );
      case AppRoutesName.detection:
        return MaterialPageRoute(
          builder: (context) => Detection(),
        );
      case AppRoutesName.signUp:
        return MaterialPageRoute(
          builder: (context) => SignUp(),
        );
      case AppRoutesName.details:
        return MaterialPageRoute(
          builder: (context) => Details(),
        );
      case AppRoutesName.login:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );

      default:
        return MaterialPageRoute(builder: (context) =>unDefienedRoutes() ,);
     }
   }
}
Widget unDefienedRoutes(){
  return Scaffold(
    appBar: AppBar(),
    body: Center(child: Text("UnDefined Routes")),
  );
}