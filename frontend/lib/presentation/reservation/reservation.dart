import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_notifier.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';

class Reservation extends BasePage<ReservationNotifier, ReservationState> {
  Reservation({super.key}) : super(provider: reservationNotifierProvider);

  static const route = '/reservation';

  @override
  Widget buildContent(
    BuildContext context,
    WidgetRef ref,
    ReservationState state,
  ) {
    return Container();
  }
}
