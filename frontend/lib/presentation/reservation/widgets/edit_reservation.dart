import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditReservation extends StatelessWidget {
  const EditReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 20,
      children: [

      ],
    );
  }
}

void openEditReservation({required BuildContext context, required WidgetRef ref}) async {
  await showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.45,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    builder: (_) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.45,
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: EditReservation()


      );
    },
  );
}
