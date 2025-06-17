import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/news_view_model.dart';
import '../utilities/app_constants.dart';
import '../utilities/app_strings.dart';

void showSortBottomSheet(BuildContext context) {
  final viewModel = Provider.of<NewsViewModel>(context, listen: false);
  SortOrder selectedSort = viewModel.sortOrder;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppStrings.sortBy,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                title: Text(AppStrings.sortByLatest),
                trailing: selectedSort == SortOrder.newestFirst
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setModalState(() {
                    selectedSort = SortOrder.newestFirst;
                  });
                  viewModel.applySort(SortOrder.newestFirst);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(AppStrings.sortByOldest),
                trailing: selectedSort == SortOrder.oldestFirst
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setModalState(() {
                    selectedSort = SortOrder.oldestFirst;
                  });
                  viewModel.applySort(SortOrder.oldestFirst);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: AppConstants.defaultPadding),
            ],
          );
        },
      );
    },
  );
}