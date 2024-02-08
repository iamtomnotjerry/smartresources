import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smartresource/data/data_sources/product/product_source.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/presentation/product_details_two_screen/product_details_two_screen.dart';
import 'package:smartresource/services/product_service.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';

import 'widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

// import '../shop_screen/widgets/userprofilelist_item_widget.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final PagingController<int, ProductModel> _pagingController = PagingController(firstPageKey: 1);

  late StreamSubscription<QuerySnapshot> listener;

  final int limit = 10;

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<void> _fetchPage(int pageKey) async {
    try {
      final currentItems = _pagingController.value.itemList;

      final newItems = await ProductService().getProductWithPagination(
        page: pageKey,
        limit: limit,
        lastVisisbleId: currentItems != null && currentItems.isNotEmpty ? currentItems.last.id : null,
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
    listener = FirebaseFirestore.instance.collection('products').snapshots().listen(
      (event) {
        _pagingController.refresh();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView (
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 23.h),
            child: Column(
              children: [
              SizedBox(height: 54.v),
              _buildShopRow(context),
              SizedBox(height: 11.v),
              _buildSearchBarRow(context),
              SizedBox(height: 10.v),
              _buildProductsList(context),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.addPrpdcutScreen);
        }, 
        child: CustomIconButton(
          height: 40.0,
          width: 40.0,
          padding: const EdgeInsets.all(8.0),
          decoration: IconButtonStyleHelper.fillPrimaryTL12,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      )
    );
  }

  /// Section Widget
  Widget _buildShopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            "Shop",
            style: CustomTextStyles.headlineSmallPrimary,
          ),
        ),
        Container(
          height: 28.adaptSize,
          width: 28.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
          child: const Stack(
            alignment: Alignment.topRight,
            children: [
                Icon(Icons.shopping_cart),
            ],
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSearchBarRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomSearchView(
            controller: searchController,
            hintText: "Search",
            borderDecoration: SearchViewStyleHelper.fillGray,
            fillColor: appTheme.gray100,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(12.h),
            decoration: IconButtonStyleHelper.fillPrimaryTL12,
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildProductsList(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container (
        decoration: AppDecoration.outlineBlack,
        child: 
        // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('products').snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     }
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return CircularProgressIndicator();
        //       default:
        //         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
        //           return Center(child:Text('No product Found', style: CustomTextStyles.headlineSmallPrimary));
        //         }
        //         return Column (
        //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //             final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //             List<String> images = [];
        //             if (data['images'] != null) {
        //               images = (data['images'] as List).map((e) => e.toString()).toList();
        //             }
        //             return ShopItemWidget(
        //               prodname: data['prodName'], 
        //               description: data['description'], 
        //               seller: data['userEmail'], 
        //               price: data['price'], 
        //               images: images, 
        //               onTap: () {
        //                 Navigator.push(context, MaterialPageRoute(
        //                   builder: (context) => ProductDetailsTwoScreen(
        //                     prodname: data['prodName'], 
        //                     description: data['description'], 
        //                     seller: data['userEmail'], 
        //                     price: data['price'], 
        //                     images: images, 
        //                   )
        //                 ));
        //               }
        //             );
        //           }).toList(),
        //         );
        //     }
        //   }
        // )
        PagedListView<int, ProductModel> (
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProductModel>(
            itemBuilder: (context, item, index) => ShopItemWidget(product: item)
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    listener.cancel();
    super.dispose();
  }
}
