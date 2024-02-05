import 'package:smartresource/data/data_sources/product/product_source.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/presentation/product_details_two_screen/product_details_two_screen.dart';

import 'widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

// import '../shop_screen/widgets/userprofilelist_item_widget.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Navigator(
  //       key: navigatorKey,
  //       onGenerateRoute: (settings) {
  //         return MaterialPageRoute(
  //           settings: settings,
  //           builder: (context) => _buildShopScreenContent(context),
  //         );
  //       },
  //     ),
  //   );
  // }

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
        child: ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productslist.length,
          itemBuilder: (context, index) {
            ProductModel prodInfo = productslist[index];
            return ShopItemWidget(
              prodname: prodInfo.prodname,
              description: prodInfo.description,
              seller: prodInfo.seller,
              price: prodInfo.price,
              image: prodInfo.image[0],
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsTwoScreen(prodname: prodInfo.prodname, description: prodInfo.description, seller: prodInfo.seller, price: prodInfo.price, image: prodInfo.image, )));
              },
            );
          },
        )
      )
    );
  }
}
