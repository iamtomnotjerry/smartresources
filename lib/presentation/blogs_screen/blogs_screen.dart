import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/presentation/blogs_screen/widgets/single_blog.dart';
import 'package:smartresource/services/blog_service.dart';
import 'package:smartresource/widgets/search_bar.dart';

class BlogsScreen extends StatefulWidget {
  BlogsScreen({Key? key}) : super(key: key);

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final PagingController<int, BlogModel> _pagingController =
      PagingController(firstPageKey: 1);

  final int limit = 10;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final currentItems = _pagingController.value.itemList;

      final newItems = await BlogsService().getBlogsWithPagination(
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
                    builder: (context) => AddBlogScreen(),
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
                const SearchBar(),
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
    super.dispose();
  }
}
