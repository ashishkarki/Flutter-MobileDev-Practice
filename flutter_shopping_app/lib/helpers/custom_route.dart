import 'package:flutter/material.dart';

// specific route transition: see usage in app_drawer
class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder widgetBuilder,
    RouteSettings routeSettings,
  }) : super(
          builder: widgetBuilder,
          settings: routeSettings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      // if this is the first page loaded in the app, don't animate. just return the child however it is.
      return child;
    }

    // else animate the transitions into this page.
    // return FadeTransition(
    //   opacity: animation,
    //   child: child,
    // );
    // return RotationTransition(
    //   turns: animation,
    //   child: child,
    // );
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}

// general theme that affects all reoute transtions: setup in main.dart
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (route.settings.isInitialRoute) {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
