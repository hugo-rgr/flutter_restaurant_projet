// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ErrorState {
  String get message => throw _privateConstructorUsedError;
  Object get exception => throw _privateConstructorUsedError;
  StackTrace? get stack => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      Object exception,
      StackTrace? stack,
    )
    stringError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, Object exception, StackTrace? stack)?
    stringError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Object exception, StackTrace? stack)?
    stringError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringError value) stringError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringError value)? stringError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringError value)? stringError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorStateCopyWith<ErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorStateCopyWith<$Res> {
  factory $ErrorStateCopyWith(
    ErrorState value,
    $Res Function(ErrorState) then,
  ) = _$ErrorStateCopyWithImpl<$Res, ErrorState>;
  @useResult
  $Res call({String message, Object exception, StackTrace? stack});
}

/// @nodoc
class _$ErrorStateCopyWithImpl<$Res, $Val extends ErrorState>
    implements $ErrorStateCopyWith<$Res> {
  _$ErrorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? exception = null,
    Object? stack = freezed,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            exception: null == exception ? _value.exception : exception,
            stack:
                freezed == stack
                    ? _value.stack
                    : stack // ignore: cast_nullable_to_non_nullable
                        as StackTrace?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StringErrorImplCopyWith<$Res>
    implements $ErrorStateCopyWith<$Res> {
  factory _$$StringErrorImplCopyWith(
    _$StringErrorImpl value,
    $Res Function(_$StringErrorImpl) then,
  ) = __$$StringErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object exception, StackTrace? stack});
}

/// @nodoc
class __$$StringErrorImplCopyWithImpl<$Res>
    extends _$ErrorStateCopyWithImpl<$Res, _$StringErrorImpl>
    implements _$$StringErrorImplCopyWith<$Res> {
  __$$StringErrorImplCopyWithImpl(
    _$StringErrorImpl _value,
    $Res Function(_$StringErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? exception = null,
    Object? stack = freezed,
  }) {
    return _then(
      _$StringErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        exception: null == exception ? _value.exception : exception,
        stack:
            freezed == stack
                ? _value.stack
                : stack // ignore: cast_nullable_to_non_nullable
                    as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$StringErrorImpl implements StringError {
  const _$StringErrorImpl({
    required this.message,
    required this.exception,
    this.stack,
  });

  @override
  final String message;
  @override
  final Object exception;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'ErrorState.stringError(message: $message, exception: $exception, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(exception),
    stack,
  );

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StringErrorImplCopyWith<_$StringErrorImpl> get copyWith =>
      __$$StringErrorImplCopyWithImpl<_$StringErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      Object exception,
      StackTrace? stack,
    )
    stringError,
  }) {
    return stringError(message, exception, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, Object exception, StackTrace? stack)?
    stringError,
  }) {
    return stringError?.call(message, exception, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, Object exception, StackTrace? stack)?
    stringError,
    required TResult orElse(),
  }) {
    if (stringError != null) {
      return stringError(message, exception, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringError value) stringError,
  }) {
    return stringError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StringError value)? stringError,
  }) {
    return stringError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringError value)? stringError,
    required TResult orElse(),
  }) {
    if (stringError != null) {
      return stringError(this);
    }
    return orElse();
  }
}

abstract class StringError implements ErrorState {
  const factory StringError({
    required final String message,
    required final Object exception,
    final StackTrace? stack,
  }) = _$StringErrorImpl;

  @override
  String get message;
  @override
  Object get exception;
  @override
  StackTrace? get stack;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StringErrorImplCopyWith<_$StringErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
