import 'package:flutter/material.dart';
import '../../app.dart';
import '../../views/filter/filter_screen.dart';
import '../../views/ticket/ticket_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String filter = '/filter';
  static const String ticketDetail = '/ticket_detail';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const MainScreen(),
    filter: (context) => const FilterScreen(),
    ticketDetail: (context) => const TicketDetailScreen(),
  };
}
