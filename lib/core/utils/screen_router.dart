
import 'package:event_channel_demo/main.dart';
import 'package:event_channel_demo/view/event_channel.dart';
import 'package:event_channel_demo/view/method_channel.dart';
import 'package:flutter/material.dart';
import '../constants/page_route_constants.dart';

class ScreenRouter {
  ScreenRouter._();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteConstants.homeView:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case PageRouteConstants.eventChannelView:
        return MaterialPageRoute(builder: (_) => const EventChannelView());
      case PageRouteConstants.methodChannelView:
        return MaterialPageRoute(builder: (_) => const MethodChannelView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
