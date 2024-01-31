import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged, this.currentIndex});
  
  Function(BottomBarEnum)? onChanged;
  int ?currentIndex;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      title: "Home",
      type: BottomBarEnum.home,
      route: AppRoutes.homeScreen
    ),
    BottomMenuModel(
      icon: ImageConstant.imgPlayCircle,
      activeIcon: ImageConstant.imgPlayCircle,
      title: "Tutorials",
      type: BottomBarEnum.tutorials,
      route: AppRoutes.tutorialsScreen,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgTelevision,
      activeIcon: ImageConstant.imgTelevision,
      title: "Blogs",
      type: BottomBarEnum.blogs,
      route: AppRoutes.blogsScreen
    ),
    BottomMenuModel(
      icon: ImageConstant.imgThumbsUp,
      activeIcon: ImageConstant.imgThumbsUp,
      title: "Shop",
      type: BottomBarEnum.shop,
      route: AppRoutes.shopScreen
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLock,
      activeIcon: ImageConstant.imgLock,
      title: "Profile",
      type: BottomBarEnum.profile,
      route: AppRoutes.profileScreen,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.v,
      decoration: BoxDecoration(),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: widget.currentIndex!,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: SizedBox(
              height: 41.v,
              width: 27.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 1.v),
                      decoration: AppDecoration.fillOnPrimaryContainer,
                      child: CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        color: appTheme.blueGray70001,
                        margin: EdgeInsets.only(
                          left: 1.h,
                          right: 1.h,
                          bottom: 16.v,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 28.v),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: appTheme.blueGray70001,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            activeIcon: SizedBox(
              height: 40.v,
              width: 29.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: AppDecoration.fillOnPrimaryContainer,
                      child: CustomImageView(
                        imagePath: bottomMenuList[index].activeIcon,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        color: theme.colorScheme.primary,
                        margin: EdgeInsets.only(
                          left: 2.h,
                          right: 2.h,
                          bottom: 16.v,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 27.v),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        style: CustomTextStyles.labelMediumPrimary.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          // selectedIndex = index;
          Navigator.pushNamed(context, bottomMenuList[index].route);
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  home,
  tutorials,
  blogs,
  shop,
  profile, 
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
    required this.route,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;

  String route;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
