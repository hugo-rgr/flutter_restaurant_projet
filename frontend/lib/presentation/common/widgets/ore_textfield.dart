import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class OreTextField extends ConsumerWidget {
  const OreTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.namingText,
    this.withBorder = true,
    this.withElevation =  false,
    this.maxLines = 1,
    this.textInputType,
  });
  final String hintText;
  final String? namingText;
  final bool withBorder;
  final int maxLines;
  final bool withElevation;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Material(
             // elevation: withElevation ? 2 : 0,
              borderRadius: BorderRadius.circular(7),

              child: TextFormField(

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: textInputType ?? TextInputType.text,
                controller: controller,
                onChanged: onChanged,
                maxLines: maxLines,

                decoration: InputDecoration(


                  hintText: hintText,
                  hintStyle: TextStyle(
                  ),
                  filled: true,
                  enabledBorder:
                  withBorder
                      ? OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(7.0),
                  )
                      : null,
                  focusedBorder: withBorder
                      ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ): null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OreDropdown extends ConsumerWidget {
  const OreDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.onTap,
  });
  final List<String> items;
  final void Function(String?) onChanged;
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(
              'Which level do you think you have ?',
              style: TextStyle(
                fontSize: 14,
              ),

            ),
            onChanged: onChanged,

            onTap: () async {},
            items:
            items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value != '' ? Text(value) : SizedBox(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

String? emailValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter your email';
  }
  if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}
