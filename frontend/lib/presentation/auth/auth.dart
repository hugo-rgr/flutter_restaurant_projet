import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_notifier.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';

class Auth extends BasePage<AuthNotifier, AuthState> {
  Auth({super.key}) : super(provider: authNotifierProvider);

  static const route = '/auth';

  @override
  Widget buildContent(
      BuildContext context,
      WidgetRef ref,
      AuthState state,
      ) {
    return Container();
  }
}
