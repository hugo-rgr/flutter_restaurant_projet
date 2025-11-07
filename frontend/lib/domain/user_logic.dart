import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/models/user.dart';
import '../services/prefs/prefs_service.dart';


final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref: ref);
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier({required this.ref}) : super(null);
  final Ref ref;
  PreferencesService get _prefs => ref.read(prefsProvider);



  Future<void> setUser(User user) async {
    try {
      state = user;
    } catch (e) {
      print('errorrrrrrrrrrrr');
      rethrow;
    }
  }

  Future<void> killUser() async {
    state = null;
  }


}
