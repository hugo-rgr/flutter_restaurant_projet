import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/presentation/splash/splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/router_observer.dart';


// identifier = 37fd36f8-7adc-4401-a9ba-1c2a080a04cf

// key = 4976f5ba8ddc6b6d3d9618fa38d7b2c05ed36afebd4aca4e93b6f73954ba88f2

final scaffoldMessengerProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
      (ref) =>
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldMessengerKey'),
);

final routerKeyProvider = Provider<GlobalKey<NavigatorState>>(
      (ref) => GlobalKey<NavigatorState>(debugLabel: 'navigatorKey'),
);

class App extends ConsumerStatefulWidget with WidgetsBindingObserver {
  const App({super.key});

  static final routeObserver = MyRouteObserver();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routerKey = ref.read(routerKeyProvider);
    final scaffoldMessengerKey = ref.read(scaffoldMessengerProvider);
    final routerObserver = ref.read(routerObserverProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        navigatorKey: routerKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Splash.route,
        routes: {Splash.route: (_) => Splash()},
        navigatorObservers: [routerObserver],
      ),
    );
  }
}

class MyRouteObserver extends RouteObserver<PageRoute<void>> {
  @override
  void didReplace({Route<void>? newRoute, Route<void>? oldRoute}) {
    super.didReplace();
    if (newRoute != null) {
      didPop(newRoute, oldRoute);
    }
  }
}
