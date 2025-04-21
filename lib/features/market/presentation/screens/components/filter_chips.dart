import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class FilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['Все', 'Новые', 'С пробегом'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                selected: isSelected,
                label: Text(
                  filter,
                  style: AppTheme.bodyMedium.copyWith(
                    color: isSelected ? Colors.white : AppTheme.greyText,
                  ),
                ),
                backgroundColor: Colors.white,
                selectedColor: AppTheme.main,
                side: BorderSide(
                  color: isSelected ? AppTheme.main : AppTheme.greyText,
                ),
                onSelected: (_) => onFilterSelected(filter),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
