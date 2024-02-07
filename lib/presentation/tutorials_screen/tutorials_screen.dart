import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/tutorial/materials_purposes.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/add_tutorial_screen/add_tutorial_screen.dart';
import 'package:smartresource/services/tutorials_service.dart';
import 'package:smartresource/widgets/search_bar.dart';

import 'widgets/chip.dart';
import 'widgets/tutorial_item.dart';

class TutorialsScreen extends StatefulWidget {
  TutorialsScreen({Key? key});

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  final PagingController<int, TutorialModel> _pagingController =
      PagingController(firstPageKey: 1);

  final int limit = 10;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final currentItems = _pagingController.value.itemList;

      final newItems = await TutorialService().getTutorialsWithPagination(
        page: pageKey,
        limit: limit,
        lastVisibleId: currentItems != null && currentItems.isNotEmpty
            ? currentItems.last.id
            : null,
      );
      final isLastPage = newItems.length < limit;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Tutorials',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTutorialScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.add_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBar(),
              const SizedBox(height: 32),
              const Text(
                "Materials",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                runSpacing: -4,
                spacing: 8,
                children: List<Widget>.generate(
                  tutorialMaterials.take(10).length,
                  (index) => CustomChip(
                    text: tutorialMaterials.take(10).toList()[index],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Purposes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                runSpacing: -4,
                spacing: 8,
                children: List<Widget>.generate(
                  tutorialPurposes.take(10).length,
                  (index) => CustomChip(
                    text: tutorialPurposes.take(10).toList()[index],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PagedListView<int, TutorialModel>(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<TutorialModel>(
                  itemBuilder: (context, item, index) => TutorialItem(
                    tutorial: item,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
