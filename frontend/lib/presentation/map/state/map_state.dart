import '../../common/base_state.dart';

class MapState with BaseState {
  final double latitude;
  final double longitude;
  const MapState({this.latitude = 48.8566, this.longitude = 2.3522});

  MapState copyWith({double? latitude, double? longitude}) => MapState(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory MapState.initial() => const MapState();
}
