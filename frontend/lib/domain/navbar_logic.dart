import 'package:flutter_riverpod/flutter_riverpod.dart';


final navIndexProvider = StateNotifierProvider<NavNotifier, int>((ref) {
  return NavNotifier(ref: ref);
});

class NavNotifier extends StateNotifier<int> {
  NavNotifier({required this.ref}) : super(0);
  final Ref ref;

  void onBottomNavigationTap(int index) {
    state = index;
  }
}
