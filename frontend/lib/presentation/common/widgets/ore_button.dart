import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/common/themes/colors/ore_colors.dart';

class OreButton extends StatelessWidget {
  const OreButton({
    super.key,
    required this.onTap,
    this.isActive = true,
    this.text,
    this.widget,
  });
  final bool isActive;
  final String? text;
  final Widget? widget;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width - 32,
        height: 50,
        decoration: BoxDecoration(
          color:
              isActive
                  ? OreColors.instance.backgroundColor
                  : OreColors.instance.backgroundColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child:
              text != null
                  ? Text(
                    text!.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                  : widget,
        ),
      ),
    );
  }
}
