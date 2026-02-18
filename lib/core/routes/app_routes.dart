import 'package:flutter/material.dart';
import '../../app.dart';
import '../../views/filter/filter_screen.dart';
import '../../views/ticket/ticket_detail_screen.dart';
import '../../views/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String filter = '/filter';
  static const String ticketDetail = '/ticket_detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case filter:
        return _buildPageRoute(
          const FilterScreen(),
          offset: const Offset(0, 1), // Slide from Bottom
        );
      case ticketDetail:
        return _buildPageRoute(
          const TicketDetailScreen(),
          settings: settings,
          offset: const Offset(1, 0), // Slide from Right
        );
      default:
        return null;
    }
  }

  static PageRouteBuilder _buildPageRoute(
    Widget page, {
    RouteSettings? settings,
    Offset offset = const Offset(1, 0),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = offset;
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }
}
