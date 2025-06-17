import 'package:flutter/material.dart';
import '../utilities/app_strings.dart';
import '../widgets/circular_outline.dart';


class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomSearchTextField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: AppStrings.searchPlaceholder,
        border: CircularOutline.circularOutline(),
        focusedBorder: CircularOutline.circularOutline(),
        enabledBorder: CircularOutline.circularOutline(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        prefixIcon: const Icon(Icons.search),
        suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        suffixIcon: IconButton(
           icon: const Icon(Icons.clear),
           onPressed: () {
              controller.clear();
              focusNode.unfocus();
            },
        ),
      ),
    );
  }
}

