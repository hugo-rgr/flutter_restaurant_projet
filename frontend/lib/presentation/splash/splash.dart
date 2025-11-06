import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/splash/state/spalsh_notifier.dart';
import 'package:flutter_restaurant_app/presentation/splash/state/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';


class SplashPage extends BasePage<SplashNotifier, SplashState> {
  SplashPage({super.key}) : super(provider: splashNotifierProvider);
  static const route = '/';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, SplashState state) {
    return Center(
    );
  }
}
