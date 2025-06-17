import 'package:flutter/material.dart';
import 'shimmer_card.dart';
import '../utilities/app_constants.dart';

class CustomLoaderInGridView {
  static Widget customLoaderInGridView() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.elementSpacing,
        mainAxisSpacing: AppConstants.elementSpacing,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => const ShimmerCard(),
    );
  }
}