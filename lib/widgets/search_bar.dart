import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class SearchBar extends StatelessWidget {
  Function() onTap;
  TextEditingController searchController;
  SearchBar({
    super.key,
    required this.onTap, required this.searchController, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomTextFormField(
              
              controller: searchController,
              hintText: 'Search...',
              prefix: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 12,
                ),
                child: Icon(
                  Icons.search,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          width: 52,
          height: 52,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
