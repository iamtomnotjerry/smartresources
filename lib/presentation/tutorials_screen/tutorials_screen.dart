import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/tutorial/materials_purposes.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/add_tutorial_screen/add_tutorial_screen.dart';
import 'package:smartresource/services/tutorials_service.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

import 'widgets/chip.dart';
import 'widgets/tutorial_item.dart';

class TutorialsScreen extends StatefulWidget {
  const TutorialsScreen({
    super.key,
  });

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  final PagingController<int, TutorialModel> _pagingController =
      PagingController(firstPageKey: 1);

  late StreamSubscription<QuerySnapshot> listener;

  final int limit = 10;

  TextEditingController searchController = TextEditingController();

  Future<void> _fetchPage(int pageKey, {String? searchTerm}) async {
    try {
      final currentItems = _pagingController.value.itemList;
      List<TutorialModel> newItems = [];
      if (searchTerm == null) {
        newItems = await TutorialService().getTutorialsWithPagination(
          page: pageKey,
          limit: limit,
          lastVisibleId: currentItems != null && currentItems.isNotEmpty
              ? currentItems.last.id
              : null,
        );
      } else {
        newItems = await TutorialService().searchTutorials(searchTerm);
      }
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
      _fetchPage(pageKey, searchTerm: searchController.text);
    });
    listener = FirebaseFirestore.instance
        .collection('tutorials')
        .snapshots()
        .listen((event) {
      _pagingController.refresh();
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
                    builder: (context) => const AddTutorialScreen(),
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
              CustomSearchView(
                onChanged: (value) {
                  _pagingController.refresh();
                },
                onPressed: () {
                  searchController.clear();
                  _pagingController.refresh();
                },
                controller: searchController,
                hintText: "Search",
                autofocus: false,
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
                borderDecoration: SearchViewStyleHelper.fillGray,
                fillColor: appTheme.gray100,
                textStyle: CustomTextStyles.bodyLargeBlack900,
              ),
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
    listener.cancel();
    super.dispose();
  }
}
