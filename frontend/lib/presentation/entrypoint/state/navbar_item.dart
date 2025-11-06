import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BottomAppBarItem extends ConsumerWidget {
  const BottomAppBarItem({
    super.key,
    required this.name,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  final String name;
  final bool isActive;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final theme = ref.read(themeManagerProvider);
    return InkWell(
      onTap: onTap,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              icon,
              color:
              isActive
                  ? Colors.red
                  : Colors.blue,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color:
              isActive
                  ? Colors.red
                  : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
