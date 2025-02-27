import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeittt/utils/user_controller.dart';

class FilterChipsScreen extends StatelessWidget {
  final filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
      spacing: 5,
      runSpacing: 5,
      children: filterController.filters
          .map((filter) => ChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle,
                size: 14,
                color: filterController.selectedFilter.value == filter
                    ? Colors.white
                    : Colors.black),
            const SizedBox(width: 4),
            Text(filter,
                style: TextStyle(
                    fontSize: 10,
                    color: filterController.selectedFilter.value == filter
                        ? Colors.white
                        : Colors.black)),
          ],
        ),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        showCheckmark: false,
        selected: filterController.selectedFilter.value == filter,
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.grey[200],
        onSelected: (_) => filterController.selectFilter(filter),
        labelStyle: TextStyle(
          color: filterController.selectedFilter.value == filter
              ? Colors.white
              : Colors.black,
        ),
      ),
      )
          .toList(),//.toList() is used in Dart to convert an iterable (like a map, set, or generator) into a list.
    ));
  }
}
