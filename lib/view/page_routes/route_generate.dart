import 'package:flutter/material.dart';
import 'package:shortnews/view/change_language_screen.dart';
import 'package:shortnews/view/dashboard_screeen.dart';
import 'package:shortnews/view/listdata.dart';
import 'package:shortnews/view/page_routes/routes.dart';
import 'package:shortnews/view/splash_Screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = SplashScreen();
        break;

      case Routes.dashBoardScreenActivity:
        widgetScreen = DashBoardScreenActivity(
          type: '',
          notification: '',
        );
        break;
        case Routes.newsListPage:
        widgetScreen = NewsListPage(
     
        );
        break;

        

      default:
        widgetScreen = SplashScreen();
    }
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widgetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('ERROR'),
      ),
    );
  }
}
