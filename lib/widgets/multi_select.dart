import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:smartresource/core/app_export.dart';

class MultiSelect extends StatelessWidget {
  const MultiSelect({
    super.key,
    required this.label,
    required this.selectedItems,
    required this.items,
    required this.onChange,
    this.title,
    this.hintText,
  });

  final String label;
  final List<String> selectedItems;
  final List<String> items;
  final void Function(List<String>) onChange;
  final String? title;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          MultiSelectDialogField(
            items: items.map((e) => MultiSelectItem(e, e)).toList(),
            onConfirm: onChange,
            decoration: BoxDecoration(
              color: appTheme.blueGray50.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            buttonIcon: const Icon(Icons.unfold_more),
            searchable: true,
            title: title != null ? Text(title!) : null,
            buttonText: hintText != null
                ? Text(
                    hintText!,
                    style: theme.textTheme.bodyLarge,
                  )
                : null,
            chipDisplay: MultiSelectChipDisplay(
              items: selectedItems.map((e) => MultiSelectItem(e, e)).toList(),
              onTap: (value) {
                final newItems =
                    selectedItems.where((e) => e != value).toList();
                onChange(newItems);
                return newItems;
              },
            ),
          ),
        ],
      ),
    );
  }
}
