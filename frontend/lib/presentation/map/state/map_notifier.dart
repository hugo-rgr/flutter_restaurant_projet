import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';
import 'map_state.dart';

final mapNotifierProvider =
    AsyncNotifierProvider.autoDispose<MapNotifier, MapState>(MapNotifier.new);

class MapNotifier extends BaseStateNotifier<MapState> {
  MapNotifier() : super(initialState: const MapState());

  @override
  FutureOr<void> refresh() async {
    // Placeholder pour logic future (ex: récupérer coordonnées depuis backend)
  }

  void setCoordinates(double lat, double lng) {
    currentState = MapState(latitude: lat, longitude: lng);
  }
}
