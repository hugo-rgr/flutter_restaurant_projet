import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/entrypoint/state/navbar.dart';
import 'package:flutter_restaurant_app/presentation/menu/menu.dart';
import 'package:flutter_restaurant_app/presentation/profile/profile.dart';
import 'package:flutter_restaurant_app/presentation/reservation/reservation.dart';
import 'package:flutter_restaurant_app/presentation/map/map_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animations/animations.dart';
import '../../domain/navbar_logic.dart';


/// This page will contain all the bottom navigation tabs

class EntryPointUI extends ConsumerStatefulWidget {
  const EntryPointUI({super.key});
  static const route = '/entrypoint';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends ConsumerState<EntryPointUI> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Menu(),
      ReservationPage(),
      MapPage(),
      Profile()
    ];

    //final cart = ref.watch(cartProvider);
   // final theme = ref.read(themeManagerProvider);
    final currentIndex = ref.watch(navIndexProvider);

    return


      Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
             // fillColor: theme.colors.backgroundColor,
              child: child,
            );
          },
          child: pages[currentIndex],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: currentIndex,
          onNavTap: ref.read(navIndexProvider.notifier).onBottomNavigationTap,
        ),
      );
  }
}
