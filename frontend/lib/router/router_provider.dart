import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/router/router_observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/app.dart';


final myRouterProvider = Provider<MyRouter>(MyRouter.new);

class MyRouter {
  MyRouter(this.ref);

  Ref ref;

  BuildContext get routerContext => ref.read(routerKeyProvider).currentContext!;

  NavigatorState get navigator => ref.read(routerKeyProvider).currentState!;

  List<RouteStackItem> get routerStack =>
      ref.read(routerObserverProvider).navStack;

  //AppLogger get logger => ref.read(appLoggerProvider);

  bool isCurrentPage(String pageName) {
    if (routerStack.last.name == pageName) {
      return true;
    }
    return false;
  }

  Future<T?> push<T extends Object>(
      Widget page,
      String pageName, {
        bool fromBottom = false,
      }) async {
    final result = await navigator.push<T>(
      createSlideRoute(page, fromBottom: fromBottom, pageName: pageName),
    );

    return result;
  }

  Future<T?> pushNamed<T extends Object>(String pageName) async {
    final result = await navigator.pushNamed<T?>(pageName);
    return result;
  }

  Future<T?> pushAndRemoveUntil<T extends Object>(
      Widget page,
      String pageName,
      ) async {
    final result = await navigator.pushAndRemoveUntil<T>(
      createFadeRoute(page),
          (route) => false,
    );
    return result;
  }

  Future<T?> pushReplacement<T extends Object>(
      Widget page,
      String pageName,
      ) async {
    return navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: pageName),
      ),
    );
  }

  Future<T?> pushReplacementNamed<T extends Object>(String pageName) async {
    return navigator.pushReplacementNamed(pageName);
  }

  /*Future<T?> pushDialog<T extends Object>(Widget page, String pageName) async {
    return navigator.push(
      DialogPage<T>(child: page, pageName: pageName).createRoute(routerContext),
    );
  }*/

  void pop<T extends Object>({T? result}) {
    navigator.pop<T>(result);
  }

  static Route<T> createSlideRoute<T extends Object>(
      Widget view, {
        required bool fromBottom,
        required String pageName,
      }) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = fromBottom ? const Offset(0, 1) : const Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      settings: RouteSettings(name: pageName),
    );
  }

  static Route<dynamic> createFadingRoute(
      Widget view, {
        required bool fromBottom,
      }) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = fromBottom ? const Offset(0, 1) : const Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Route<T> createFadeRoute<T extends Object>(Widget view) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeIn));
        return FadeTransition(opacity: animation.drive(tween), child: child);
      },
    );
  }
}
