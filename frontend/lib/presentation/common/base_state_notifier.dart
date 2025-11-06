import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../router/router_provider.dart';
import 'errors/error_state.dart';


typedef RefreshFunction = Future<void> Function();

mixin BaseNotifierLifecycleMixin {
  void dispose();
}

mixin BaseAsyncNotifierMixin<T> implements BaseNotifierLifecycleMixin {
  MyRouter get router;
  //AppLogger get logger;

  void _setData(T data);

  T? initialState;
  late T _currentState;

  bool isInitialized = false;

  T get currentState => _currentState;

  set currentState(T model) {
    _currentState = model;
    _setData(model);
  }

  void notifyListener() {
    currentState = _currentState;
  }

  FutureOr<T> buildInternal(RefreshFunction refreshFunction) async {
    if (initialState != null) {
      currentState = initialState as T;
    }

    try {
      await refreshFunction.call();
      isInitialized = true;
      return currentState;
    } catch (e, stack) {
    /*  logger.error(
        e.toString(),
        error: e,
        stackTrace: stack,
      );*/
      throw ErrorState.stringError(
        message: e.toString(),
        exception: e,
        stack: stack,
      );
    }
  }
}

abstract class BaseStateNotifier<T> extends AutoDisposeAsyncNotifier<T>
    with BaseAsyncNotifierMixin<T> {
  BaseStateNotifier({T? initialState}) {
    super.initialState = initialState;
  }

  @override
  MyRouter get router => ref.read(myRouterProvider);

  @override
  //AppLogger get logger => ref.read(appLoggerProvider);

  @override
  FutureOr<T> build() {
    return buildInternal(() async => await refresh());
  }

  @override
  void _setData(T data) {
    state = AsyncValue.data(data);
  }

  FutureOr<void> refresh();

  @override
  void dispose() {}
}

abstract class BaseStateNotifierWithArg<T, Arg>
    extends AutoDisposeFamilyAsyncNotifier<T, Arg>
    with BaseAsyncNotifierMixin<T> {
  BaseStateNotifierWithArg({T? initialState}) {
    super.initialState = initialState;
  }

  @override
  MyRouter get router => ref.read(myRouterProvider);

  @override
  FutureOr<T> build(Arg arg) async {
    return buildInternal(() async => await refresh(arg));
  }

  @override
  void _setData(T data) {
    state = AsyncValue.data(data);
  }

  FutureOr<void> refresh(Arg arg);

  @override
  void dispose() {}
}
