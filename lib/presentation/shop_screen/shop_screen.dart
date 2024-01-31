import '../shop_screen/widgets/userprofilelist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

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
        body: SingleChildScrollView(child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Column(
            children: [
              SizedBox(height: 54.v),
              _buildShopRow(context),
              SizedBox(height: 11.v),
              _buildSearchBarRow(context),
              SizedBox(height: 60.v),
              SizedBox(
                height: 688.v,
                width: 381.h,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: AppDecoration.outlineBlack,
                        child: _buildUserProfileList(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: EdgeInsets.only(bottom: 66.v),
                        color: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.circleBorder22,
                        ),
                        child: Container(
                          height: 44.adaptSize,
                          width: 44.adaptSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 10.v,
                          ),
                          decoration: AppDecoration.outlineBlack900.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder22,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgCartOnprimarycontainer,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                alignment: Alignment.centerLeft,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 10.adaptSize,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.h),
                                  decoration: AppDecoration.fillGreen.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.circleBorder5,
                                  ),
                                  child: Text(
                                    "1",
                                    style: CustomTextStyles.labelSmallGray600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
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
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgCart,
                height: 28.adaptSize,
                width: 28.adaptSize,
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 10.adaptSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                    vertical: 1.v,
                  ),
                  decoration: AppDecoration.outlineOnPrimaryContainer.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder5,
                  ),
                  child: Text(
                    "1",
                    style: CustomTextStyles.interOnPrimaryContainer,
                  ),
                ),
              ),
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
            child: CustomImageView(
              imagePath: ImageConstant.imgTune,
            ),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildUserProfileList(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 16.v,
        );
      },
      itemCount: 4,
      itemBuilder: (context, index) {
        return const UserprofilelistItemWidget();
      },
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 3,
    );
  }
}
