import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/presentation/blogs_screen/widgets/single_blog.dart';
import 'package:smartresource/services/blog_service.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final PagingController<int, BlogModel> _pagingController =
      PagingController(firstPageKey: 1);

  late StreamSubscription<QuerySnapshot> listener;

  final int limit = 10;

  TextEditingController searchController = TextEditingController();

  Future<void> _fetchPage(int pageKey, {String? searchTerm}) async {
    try {
      final currentItems = _pagingController.value.itemList;
      List<BlogModel> newItems = [];
      if (searchTerm == null) {
        newItems = await BlogsService().getBlogsWithPagination(
          page: pageKey,
          limit: limit,
          lastVisibleId: currentItems != null && currentItems.isNotEmpty
              ? currentItems.last.id
              : null,
        );
      } else {
        newItems = await BlogsService().searchBlogs(searchTerm);
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
    listener =
        FirebaseFirestore.instance.collection('blogs').snapshots().listen(
      (event) {
        _pagingController.refresh();
      },
    );
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
            'Blogs',
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
                    builder: (context) => const AddBlogScreen(),
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // SearchBar(
                //   onChanged: () {
                //     setState(() {
                //       _pagingController.refresh();
                //     });
                //   },
                //   searchController: searchController,
                // ),
                CustomSearchView(
                  onChanged: (value) {
                    _pagingController.refresh();
                  },
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
                  onPressed: () {
                    searchController.clear();
                    _pagingController.refresh();
                  },
                  controller: searchController,
                  hintText: "Search",
                  autofocus: false,
                  borderDecoration: SearchViewStyleHelper.fillGray,
                  fillColor: appTheme.gray100,
                  textStyle: CustomTextStyles.bodyLargeBlack900,
                ),
                const SizedBox(
                  height: 64,
                ),
                PagedListView<int, BlogModel>(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<BlogModel>(
                    itemBuilder: (context, item, index) => SingleBlogWidget(
                      blog: item,
                    ),
                  ),
                ),
              ],
            ),
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
