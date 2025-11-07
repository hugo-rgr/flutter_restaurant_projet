// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReservationState {
  List<Reservation> get reservations => throw _privateConstructorUsedError;
  List<RestaurantTable> get availableTables =>
      throw _privateConstructorUsedError;
  bool get checkingAvailability => throw _privateConstructorUsedError;
  TextEditingController get seatsController =>
      throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  DateTime? get selectedDate => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get tableSlots =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get actualSlot => throw _privateConstructorUsedError;
  Reservation? get selectedReservation => throw _privateConstructorUsedError;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationStateCopyWith<ReservationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationStateCopyWith<$Res> {
  factory $ReservationStateCopyWith(
    ReservationState value,
    $Res Function(ReservationState) then,
  ) = _$ReservationStateCopyWithImpl<$Res, ReservationState>;
  @useResult
  $Res call({
    List<Reservation> reservations,
    List<RestaurantTable> availableTables,
    bool checkingAvailability,
    TextEditingController seatsController,
    bool isAvailable,
    DateTime? selectedDate,
    List<Map<String, dynamic>> tableSlots,
    Map<String, dynamic> actualSlot,
    Reservation? selectedReservation,
  });
}

/// @nodoc
class _$ReservationStateCopyWithImpl<$Res, $Val extends ReservationState>
    implements $ReservationStateCopyWith<$Res> {
  _$ReservationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservations = null,
    Object? availableTables = null,
    Object? checkingAvailability = null,
    Object? seatsController = null,
    Object? isAvailable = null,
    Object? selectedDate = freezed,
    Object? tableSlots = null,
    Object? actualSlot = null,
    Object? selectedReservation = freezed,
  }) {
    return _then(
      _value.copyWith(
            reservations:
                null == reservations
                    ? _value.reservations
                    : reservations // ignore: cast_nullable_to_non_nullable
                        as List<Reservation>,
            availableTables:
                null == availableTables
                    ? _value.availableTables
                    : availableTables // ignore: cast_nullable_to_non_nullable
                        as List<RestaurantTable>,
            checkingAvailability:
                null == checkingAvailability
                    ? _value.checkingAvailability
                    : checkingAvailability // ignore: cast_nullable_to_non_nullable
                        as bool,
            seatsController:
                null == seatsController
                    ? _value.seatsController
                    : seatsController // ignore: cast_nullable_to_non_nullable
                        as TextEditingController,
            isAvailable:
                null == isAvailable
                    ? _value.isAvailable
                    : isAvailable // ignore: cast_nullable_to_non_nullable
                        as bool,
            selectedDate:
                freezed == selectedDate
                    ? _value.selectedDate
                    : selectedDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            tableSlots:
                null == tableSlots
                    ? _value.tableSlots
                    : tableSlots // ignore: cast_nullable_to_non_nullable
                        as List<Map<String, dynamic>>,
            actualSlot:
                null == actualSlot
                    ? _value.actualSlot
                    : actualSlot // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>,
            selectedReservation:
                freezed == selectedReservation
                    ? _value.selectedReservation
                    : selectedReservation // ignore: cast_nullable_to_non_nullable
                        as Reservation?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReservationStateImplCopyWith<$Res>
    implements $ReservationStateCopyWith<$Res> {
  factory _$$ReservationStateImplCopyWith(
    _$ReservationStateImpl value,
    $Res Function(_$ReservationStateImpl) then,
  ) = __$$ReservationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Reservation> reservations,
    List<RestaurantTable> availableTables,
    bool checkingAvailability,
    TextEditingController seatsController,
    bool isAvailable,
    DateTime? selectedDate,
    List<Map<String, dynamic>> tableSlots,
    Map<String, dynamic> actualSlot,
    Reservation? selectedReservation,
  });
}

/// @nodoc
class __$$ReservationStateImplCopyWithImpl<$Res>
    extends _$ReservationStateCopyWithImpl<$Res, _$ReservationStateImpl>
    implements _$$ReservationStateImplCopyWith<$Res> {
  __$$ReservationStateImplCopyWithImpl(
    _$ReservationStateImpl _value,
    $Res Function(_$ReservationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservations = null,
    Object? availableTables = null,
    Object? checkingAvailability = null,
    Object? seatsController = null,
    Object? isAvailable = null,
    Object? selectedDate = freezed,
    Object? tableSlots = null,
    Object? actualSlot = null,
    Object? selectedReservation = freezed,
  }) {
    return _then(
      _$ReservationStateImpl(
        reservations:
            null == reservations
                ? _value._reservations
                : reservations // ignore: cast_nullable_to_non_nullable
                    as List<Reservation>,
        availableTables:
            null == availableTables
                ? _value._availableTables
                : availableTables // ignore: cast_nullable_to_non_nullable
                    as List<RestaurantTable>,
        checkingAvailability:
            null == checkingAvailability
                ? _value.checkingAvailability
                : checkingAvailability // ignore: cast_nullable_to_non_nullable
                    as bool,
        seatsController:
            null == seatsController
                ? _value.seatsController
                : seatsController // ignore: cast_nullable_to_non_nullable
                    as TextEditingController,
        isAvailable:
            null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                    as bool,
        selectedDate:
            freezed == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        tableSlots:
            null == tableSlots
                ? _value._tableSlots
                : tableSlots // ignore: cast_nullable_to_non_nullable
                    as List<Map<String, dynamic>>,
        actualSlot:
            null == actualSlot
                ? _value._actualSlot
                : actualSlot // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
        selectedReservation:
            freezed == selectedReservation
                ? _value.selectedReservation
                : selectedReservation // ignore: cast_nullable_to_non_nullable
                    as Reservation?,
      ),
    );
  }
}

/// @nodoc

class _$ReservationStateImpl implements _ReservationState {
  const _$ReservationStateImpl({
    final List<Reservation> reservations = const [],
    final List<RestaurantTable> availableTables = const [],
    this.checkingAvailability = false,
    required this.seatsController,
    this.isAvailable = false,
    this.selectedDate = null,
    final List<Map<String, dynamic>> tableSlots = tableSlot,
    final Map<String, dynamic> actualSlot = const {
      'id': '1',
      'startTime': '08:00',
      'endTime': '9:00',
    },
    this.selectedReservation,
  }) : _reservations = reservations,
       _availableTables = availableTables,
       _tableSlots = tableSlots,
       _actualSlot = actualSlot;

  final List<Reservation> _reservations;
  @override
  @JsonKey()
  List<Reservation> get reservations {
    if (_reservations is EqualUnmodifiableListView) return _reservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservations);
  }

  final List<RestaurantTable> _availableTables;
  @override
  @JsonKey()
  List<RestaurantTable> get availableTables {
    if (_availableTables is EqualUnmodifiableListView) return _availableTables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTables);
  }

  @override
  @JsonKey()
  final bool checkingAvailability;
  @override
  final TextEditingController seatsController;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final DateTime? selectedDate;
  final List<Map<String, dynamic>> _tableSlots;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get tableSlots {
    if (_tableSlots is EqualUnmodifiableListView) return _tableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableSlots);
  }

  final Map<String, dynamic> _actualSlot;
  @override
  @JsonKey()
  Map<String, dynamic> get actualSlot {
    if (_actualSlot is EqualUnmodifiableMapView) return _actualSlot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_actualSlot);
  }

  @override
  final Reservation? selectedReservation;

  @override
  String toString() {
    return 'ReservationState(reservations: $reservations, availableTables: $availableTables, checkingAvailability: $checkingAvailability, seatsController: $seatsController, isAvailable: $isAvailable, selectedDate: $selectedDate, tableSlots: $tableSlots, actualSlot: $actualSlot, selectedReservation: $selectedReservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationStateImpl &&
            const DeepCollectionEquality().equals(
              other._reservations,
              _reservations,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableTables,
              _availableTables,
            ) &&
            (identical(other.checkingAvailability, checkingAvailability) ||
                other.checkingAvailability == checkingAvailability) &&
            (identical(other.seatsController, seatsController) ||
                other.seatsController == seatsController) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(
              other._tableSlots,
              _tableSlots,
            ) &&
            const DeepCollectionEquality().equals(
              other._actualSlot,
              _actualSlot,
            ) &&
            (identical(other.selectedReservation, selectedReservation) ||
                other.selectedReservation == selectedReservation));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_reservations),
    const DeepCollectionEquality().hash(_availableTables),
    checkingAvailability,
    seatsController,
    isAvailable,
    selectedDate,
    const DeepCollectionEquality().hash(_tableSlots),
    const DeepCollectionEquality().hash(_actualSlot),
    selectedReservation,
  );

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationStateImplCopyWith<_$ReservationStateImpl> get copyWith =>
      __$$ReservationStateImplCopyWithImpl<_$ReservationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ReservationState implements ReservationState {
  const factory _ReservationState({
    final List<Reservation> reservations,
    final List<RestaurantTable> availableTables,
    final bool checkingAvailability,
    required final TextEditingController seatsController,
    final bool isAvailable,
    final DateTime? selectedDate,
    final List<Map<String, dynamic>> tableSlots,
    final Map<String, dynamic> actualSlot,
    final Reservation? selectedReservation,
  }) = _$ReservationStateImpl;

  @override
  List<Reservation> get reservations;
  @override
  List<RestaurantTable> get availableTables;
  @override
  bool get checkingAvailability;
  @override
  TextEditingController get seatsController;
  @override
  bool get isAvailable;
  @override
  DateTime? get selectedDate;
  @override
  List<Map<String, dynamic>> get tableSlots;
  @override
  Map<String, dynamic> get actualSlot;
  @override
  Reservation? get selectedReservation;

  /// Create a copy of ReservationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationStateImplCopyWith<_$ReservationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
