import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_state.dart';
import 'base_state_notifier.dart';
import 'errors/error_state.dart';
import 'notiifer_lifecycle.dart';

mixin BasePageMixin<TProvider extends ProviderBase<AsyncValue<TState>>, TState>
    on ConsumerWidget {
  late final TProvider _provider;

  TProvider get provider => _provider;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builtDrawer = _buildDrawer(context, ref);
    return Scaffold(
      key: scaffoldKey,
      drawer: builtDrawer,
      backgroundColor: _buildBackgroundColor(ref),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: buildBody(context, ref),
      ),
      floatingActionButton: _buildFloatingActionButton(context, ref),
      bottomNavigationBar: _buildBottomNavigationBar(context, ref),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context, WidgetRef ref) {
    return ref
        .watch(provider)
        .when(
          data: (state) => buildFloatingActionButton(context, ref, state),
          error: (a, b) => buildFloatingActionButton(context, ref, null),
          loading: () => buildFloatingActionButton(context, ref, null),
        );
  }

  Widget? buildFloatingActionButton(
    BuildContext context,
    WidgetRef ref,
    TState? state,
  ) {
    return null;
  }

  Color? buildBackgroundColor(WidgetRef ref, TState? state) {
    return null;
  }

  Color? _buildBackgroundColor(WidgetRef ref) {
    return ref
        .watch(provider)
        .when(
          data: (state) => buildBackgroundColor(ref, state),
          error: (a, b) => buildBackgroundColor(ref, null),
          loading: () => buildBackgroundColor(ref, null),
        );
    ;
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    final appBar = _buildAppBar(context, ref);
    return ref
        .watch(provider)
        .when(
          data:
              (state) => Stack(
                children: [
                  if (appBar != null) appBar,
                  Padding(
                    padding: EdgeInsets.only(
                      top: appBar != null ? kToolbarHeight* (withoutAppBar() ? 0 :2) : 0,
                    ),
                    child: buildContent(context, ref, state),
                  ),
                ],
              ),
          error: buildError,
          loading: () => buildLoading(context),
        );
  }

  bool withoutAppBar() {
    return false;
  }

  Widget? _buildAppBar(BuildContext context, WidgetRef ref) {
    return ref
        .watch(provider)
        .when(
          data:
              (state) => SizedBox(
                height:
                    buildAppBar(context, ref, state) != null
                        ? kToolbarHeight*2
                        : 0,
                child: buildAppBar(context, ref, state),
              ),
          error: (a, b) => buildAppBar(context, ref, null),
          loading: () => buildAppBar(context, ref, null),
        );
  }

  Widget? buildAppBar(BuildContext context, WidgetRef ref, TState? state) {
    return null;
  }

  Widget buildContent(BuildContext context, WidgetRef ref, TState state);

  Widget buildError(Object e, StackTrace stackTrace) {
    /* if (e is ErrorState) {
      e.when(
        stringError:
            (message, exception, stack) => Center(child: Text(message)),
      );
    }*/
    return Container();
  }

  Widget buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget? buildDrawer(BuildContext context, WidgetRef ref, TState? state) {
    return null;
  }

  Widget? _buildDrawer(BuildContext context, WidgetRef ref) {
    return ref
        .watch(provider)
        .when(
          data: (state) => buildDrawer(context, ref, state),
          error: (a, b) => buildDrawer(context, ref, null),
          loading: () => buildDrawer(context, ref, null),
        );
  }

  Widget? buildBottomNavigationBar(
    BuildContext context,
    WidgetRef ref,
    TState? state,
  ) {
    return null;
  }

  Widget? _buildBottomNavigationBar(BuildContext context, WidgetRef ref) {
    return ref
        .watch(provider)
        .when(
          data: (state) => buildBottomNavigationBar(context, ref, state),
          error: (a, b) => buildBottomNavigationBar(context, ref, null),
          loading: () => buildBottomNavigationBar(context, ref, null),
        );
  }

  void openCloseDrawer() {
    if (scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
    }
  }
}

abstract class BasePage<
  TStateNotifier extends BaseStateNotifier<TState>,
  TState extends BaseState
>
    extends ConsumerWidget
    with
        BasePageMixin<
          AutoDisposeAsyncNotifierProvider<TStateNotifier, TState>,
          TState
        > {
  BasePage({
    required AutoDisposeAsyncNotifierProvider<TStateNotifier, TState> provider,
    super.key,
  }) {
    _provider = provider;
  }

  Refreshable<TStateNotifier> get notifier {
    return provider.notifier;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotifierLifecyle(
      notifier: ref.read(notifier),
      child: super.build(context, ref),
    );
  }
}

abstract class BasePageWithArg<
  TStateNotifier extends BaseStateNotifierWithArg<TState, TArg>,
  TState extends BaseState,
  TArg
>
    extends ConsumerWidget
    with
        BasePageMixin<
          AutoDisposeFamilyAsyncNotifierProvider<TStateNotifier, TState, TArg>,
          TState
        > {
  BasePageWithArg({
    required this.arg,
    required AutoDisposeFamilyAsyncNotifierProvider<
      TStateNotifier,
      TState,
      TArg
    >
    provider,
    super.key,
  }) {
    _provider = provider;
  }

  final TArg arg;

  Refreshable<TStateNotifier> get notifier {
    return provider.notifier;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotifierLifecyle(
      notifier: ref.read(notifier),
      child: super.build(context, ref),
    );
  }
}
