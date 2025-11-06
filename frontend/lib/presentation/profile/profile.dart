import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_notifier.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';

class Profile extends BasePage<ProfileNotifier, ProfileState> {
  Profile({super.key}) : super(provider: profileNotifierProvider);

  static const route = '/profile';

  @override
  Widget buildContent(
      BuildContext context,
      WidgetRef ref,
      ProfileState state,
      ) {
    return Container();
  }

  @override
  AppBar? buildAppBar(BuildContext context, WidgetRef ref, ProfileState? state) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(
        'PROFILE',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
    );
  }

  @override
  Color? buildBackgroundColor(WidgetRef ref, ProfileState? state) {
    return Colors.white;
  }
}
