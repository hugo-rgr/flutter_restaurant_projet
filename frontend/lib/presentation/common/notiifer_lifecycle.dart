import 'package:flutter/material.dart';

import 'base_state_notifier.dart';

class NotifierLifecyle extends StatefulWidget {
  const NotifierLifecyle({
    required this.child,
    required this.notifier,
    super.key,
  });

  final Widget child;
  final BaseNotifierLifecycleMixin notifier;

  @override
  State<NotifierLifecyle> createState() => _NotifierLifecyleState();
}

class _NotifierLifecyleState extends State<NotifierLifecyle> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.notifier.dispose();
    super.dispose();
  }
}
