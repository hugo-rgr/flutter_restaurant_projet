import 'dart:async';
import 'package:flutter_restaurant_app/presentation/menu/state/menu_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';


final menuNotifierProvider =
AsyncNotifierProvider.autoDispose<MenuNotifier, MenuState>(
  MenuNotifier.new,
);

class MenuNotifier extends BaseStateNotifier<MenuState> {
  MenuNotifier() : super(initialState: const MenuState());


  @override
  FutureOr<void> refresh() async {

  }

  void openMenu() {
  }

}
