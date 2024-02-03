import 'package:smartresource/data/data_sources/tutorial/tutorial_source.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';

import '../tutorials_screen/widgets/frameseven_item_widget.dart';
import '../tutorials_screen/widgets/frametwentysix_item_widget.dart';
import '../tutorials_screen/widgets/tablelamp_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

class TutorialsScreen extends StatelessWidget {
  TutorialsScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Spacer(),
            SizedBox(height: 40.0),
            _buildSearchBar(context),
            SizedBox(height: 23.v),
            Padding(
              padding: EdgeInsets.only(left: 27.h),
              child: Text(
                "Materials",
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 8.v),
            _buildFrameSeven(context),
            SizedBox(height: 10.v),
            Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: Text(
                "Purposes",
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 7.v),
            _buildFrameTwentySix(context),
            SizedBox(height: 28.v),
            Expanded(
              child: Container(
                height: 516.v,
                width: 429.h,
                margin: EdgeInsets.only(left: 1.h),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _buildTableLamp(context),
                    // _buildFrameSixteen(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchBar(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomSearchView(
                controller: searchController,
                hintText: "Search",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.h),
              // child: Icon(Icons.search),
              child: CustomIconButton(
                height: 48.adaptSize,
                width: 48.adaptSize,
                padding: EdgeInsets.all(12.h),
                decoration: IconButtonStyleHelper.fillPrimaryTL12,
                // child: CustomImageView(
                //   imagePath: ImageConstant.imgCheckmark,
                //   color: Colors.white
                // ),
                child: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameSeven(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.h),
      child: Wrap(
        runSpacing: 8.v,
        spacing: 8.h,
        children:
            List<Widget>.generate(7, (index) => const FramesevenItemWidget()),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameTwentySix(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h),
      child: Wrap(
        runSpacing: 8.v,
        spacing: 8.h,
        children: List<Widget>.generate(
            7, (index) => const FrametwentysixItemWidget()),
      ),
    );
  }

  /// Section Widget
  Widget _buildTableLamp(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 23.h),
        decoration: AppDecoration.outlineBlack,
        child: ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: tutorialsList.length,
          itemBuilder: (context, index) {
            TutorialModel tutorialItem = tutorialsList[index];
            return TablelampItemWidget(videoId: tutorialItem.videoId, title: tutorialItem.title, materials: tutorialItem.materials, instructions: tutorialItem.instructions,);
          },
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildFrameSixteen(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Container(
  //       margin: EdgeInsets.only(top: 436.v),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 39.h,
  //         vertical: 18.v,
  //       ),
  //       decoration: AppDecoration.outlineBlueGray,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             height: 40.v,
  //             width: 29.h,
  //             margin: EdgeInsets.only(top: 1.v),
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Container(
  //                     height: 40.v,
  //                     width: 29.h,
  //                     padding: EdgeInsets.symmetric(horizontal: 2.h),
  //                     decoration: AppDecoration.fillOnPrimaryContainer,
  //                     child: CustomImageView(
  //                       imagePath: ImageConstant.imgHome,
  //                       height: 24.adaptSize,
  //                       width: 24.adaptSize,
  //                       alignment: Alignment.topCenter,
  //                     ),
  //                   ),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Home",
  //                     style: CustomTextStyles.labelMediumPrimary,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 40.v,
  //             width: 42.h,
  //             margin: EdgeInsets.only(top: 1.v),
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 CustomIconButton(
  //                   height: 40.v,
  //                   width: 42.h,
  //                   alignment: Alignment.center,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgForward,
  //                   ),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Tutorials",
  //                     style: theme.textTheme.labelMedium,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 41.v,
  //             width: 27.h,
  //             margin: EdgeInsets.only(top: 1.v),
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topCenter,
  //                   child: Container(
  //                     height: 40.v,
  //                     width: 27.h,
  //                     padding: EdgeInsets.symmetric(horizontal: 1.h),
  //                     decoration: AppDecoration.fillOnPrimaryContainer,
  //                     child: CustomImageView(
  //                       imagePath: ImageConstant.imgTelevision,
  //                       height: 24.adaptSize,
  //                       width: 24.adaptSize,
  //                       alignment: Alignment.topCenter,
  //                     ),
  //                   ),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Blogs",
  //                     style: theme.textTheme.labelMedium,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 41.v,
  //             width: 25.h,
  //             margin: EdgeInsets.only(top: 1.v),
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topCenter,
  //                   child: Container(
  //                     height: 40.v,
  //                     width: 25.h,
  //                     decoration: AppDecoration.fillOnPrimaryContainer,
  //                     child: CustomImageView(
  //                       imagePath: ImageConstant.imgThumbsUp,
  //                       height: 24.adaptSize,
  //                       width: 24.adaptSize,
  //                       alignment: Alignment.topCenter,
  //                     ),
  //                   ),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Shop",
  //                     style: theme.textTheme.labelMedium,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 40.v,
  //             width: 31.h,
  //             margin: EdgeInsets.only(top: 1.v),
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Container(
  //                     height: 40.v,
  //                     width: 31.h,
  //                     padding: EdgeInsets.symmetric(horizontal: 3.h),
  //                     decoration: AppDecoration.fillOnPrimaryContainer,
  //                     child: CustomImageView(
  //                       imagePath: ImageConstant.imgLock,
  //                       height: 24.adaptSize,
  //                       width: 24.adaptSize,
  //                       alignment: Alignment.topCenter,
  //                     ),
  //                   ),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Profile",
  //                     style: theme.textTheme.labelMedium,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 1,
    );
  }
}
