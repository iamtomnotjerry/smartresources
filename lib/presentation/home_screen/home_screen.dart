import 'package:smartresource/data/data_sources/blog/blog_source.dart';
import 'package:smartresource/data/data_sources/product/product_source.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';

import 'widgets/tutorials_widget.dart';
import 'widgets/product_widget.dart';
import 'widgets/blog_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/data/data_sources/tutorial/tutorial_source.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyAuthProvider>(context).user;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: appTheme.black900,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Hi, ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            // text: '${user!.name}',
                            text: "username",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Welcome to Smart Resource!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
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
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                buildSection(
                  title: 'Tutorials',
                  body: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      aspectRatio: 1.4,
                    ),
                    itemCount: tutorialsList.length,
                    itemBuilder: (BuildContext context, int itemIndex,int pageViewIndex,) {
                      TutorialModel tutorialItem = tutorialsList[itemIndex];
                      return TutorialWidget(
                        videoId: tutorialItem.videoId, 
                        title: tutorialItem.title, 
                        materials: tutorialItem.materials, 
                        instructions: tutorialItem.instructions,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TutorialDetailsScreen(
                            videoId: tutorialItem.videoId,
                            title: tutorialItem.title,
                            materials: tutorialItem.materials,
                            instructions: tutorialItem.instructions
                          )));
                        }
                      );
                    }
                      //   buildTutorial(
                      // title:
                      //     'Table lamp making - Plastic bottle Corner Flower vase - Lighting lamp making',
                      // thumbnail: 'https://picsum.photos/${itemIndex + 500}',
                      // duration: '3:0$itemIndex',
                    ),
                  ),
                // ),
              //   const SizedBox(
              //     height: 32,
              //   ),
              // ),
              // SizedBox(height: 9.v),
              // _buildTutorials(context),
              // SizedBox(height: 15.v),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.h),
              //   child: _buildClientTestimonials(
              //     context,
              //     blogTitle: "Blogs",
              //     seeAllText: "See all",
              //     route: AppRoutes.blogsScreen
              //   ),
              // ),
              // SizedBox(height: 7.v),
              // _buildBlogs(context),
              // SizedBox(height: 12.v),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.h),
              //   child: _buildClientTestimonials(
              //     context,
              //     blogTitle: "Products",
              //     seeAllText: "See all",
              //     route: AppRoutes.blogsScreen
              //   ),
              // ),
              // SizedBox(height: 9.v),
              // _buildProducts(context),
              // SizedBox(height: 8.v),
              _buildClientTestimonials(context)
              // _buildUserProfile(context),
            ],
          ),
        )
        ),
        // bottomNavigationBar: _buildBottomBar(context),
      ));
  }

  /// Section Widget
  // Widget _buildTutorials(BuildContext context) {
  //   int num = (tutorialsList.length >= 4) ? 4 : tutorialsList.length;
  //   return SizedBox(
  //     height: 195.v,
  //     child: ListView.separated(
  //       padding: EdgeInsets.only(left: 24.h),
  //       scrollDirection: Axis.horizontal,
  //       separatorBuilder: (context,index,) {
  //         return SizedBox(
  //           width: 14.h,
  //         );
  //       },
  //       itemCount: num,
  //       itemBuilder: (context, index) {
  //         TutorialModel tutorialItem = tutorialsList[num - index - 1];
  //         return TutorialWidget(videoId: tutorialItem.videoId, title: tutorialItem.title, materials: tutorialItem.materials, instructions: tutorialItem.instructions,);
  //       },
  //     ),
  //   );
  // }

  /// Section Widget
  // Widget _buildBlogs(BuildContext context) {
  //   int num = (tutorialsList.length >= 4) ? 4 : tutorialsList.length;
  //   return SizedBox(
  //     height: 197.v,
  //     child: ListView.separated(
  //       padding: EdgeInsets.only(left: 24.h),
  //       scrollDirection: Axis.horizontal,
  //       separatorBuilder: (context, index,) {
  //         return SizedBox(
  //           width: 14.h,
  //         );
  //       },
  //       itemCount: num,
  //       itemBuilder: (context, index) {
  //         BlogModel blogItem = blogList[num - index -1];
  //         return BlogWidget(title: blogItem.title, author: blogItem.author, content: blogItem.content, image: blogItem.image);
  //       },
  //     ),
  //   );
  // }

  /// Section Widget
  // Widget _buildBlogs(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Padding(
  //       padding: EdgeInsets.only(left: 24.h, right: 45.h,),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             "Products",
  //             style: CustomTextStyles.titleMediumBlack90018,
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(vertical: 2.v),
  //             child: GestureDetector(
  //               onTap: () {
  //                 Navigator.pushNamed(context, AppRoutes.shopScreen);
  //               },
  //               child: Text(
  //                 "See all",
  //                 style: CustomTextStyles.titleSmallPrimary,
  //               ),
  //             )
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  // Widget _buildProducts(BuildContext context) {
  //   int num = (productslist.length >= 4) ? 4 : productslist.length;
  //   return SizedBox(
  //     height: 212.v,
  //     child: CarouselSlider.builder(
  //       options: CarouselOptions(
  //         autoPlay: true,
  //         viewportFraction: 1,
  //         aspectRatio: 1.2,
  //       ),
  //       itemCount: num,
  //       itemBuilder: (BuildContext context, int itemIndex,int pageViewIndex,) {
  //                     //   buildBlog(
  //                     // title:
  //                     //     'Thực hành không rác thải - Chúng ta đã thực sự hiểu?',
  //                     // thumbnail: 'https://picsum.photos/${itemIndex + 400}',
  //                     // author: 'Anonymous',
  //                     // date: 'Jan 1, 2022',
  //                     // readTime: '${itemIndex + 1}',
          
  //       }
  //     )
  //   );
  //     // );
  //   // );
  // }

  /// Section Widget
  // Widget _buildUserProfile(BuildContext context) {
  //   return Container(
  //     width: double.maxFinite,
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 40.h,
  //       vertical: 18.v,
  //     ),
  //     decoration: AppDecoration.outlineBlueGray,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           height: 40.v,
  //           width: 29.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 29.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 2.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgHome,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Home",
  //                   style: CustomTextStyles.labelMediumPrimary,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 40.v,
  //           width: 42.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               CustomIconButton(
  //                 height: 40.v,
  //                 width: 42.h,
  //                 alignment: Alignment.center,
  //                 child: CustomImageView(
  //                   imagePath: ImageConstant.imgForward,
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Tutorials",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 41.v,
  //           width: 27.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 27.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 1.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgTelevision,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Blogs",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 41.v,
  //           width: 25.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 25.h,
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgThumbsUp,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Shop",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 40.v,
  //           width: 31.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 31.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 3.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgLock,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Profile",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 0,
    );
  }

  /// Common widget
  Widget _buildClientTestimonials(
    BuildContext context, 
    // {
    // required String blogTitle,
    // required String seeAllText,
    // required String route,
  // }
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSection(
          title: 'Blogs',
          body: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              aspectRatio: 1.2,
            ),
            itemCount: blogList.length,
            itemBuilder: (BuildContext context,int itemIndex,int pageViewIndex,) {
              BlogModel blogItem = blogList[itemIndex];
              return BlogWidget(
                title: blogItem.title, 
                image: blogItem.image, 
                content: blogItem.content, 
                author: blogItem.author, 
                date: 'Jan 1, 2022', 
                readTime: '${itemIndex + 1}',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailsScreen(
                    title: blogItem.title,
                    content: blogItem.content,
                    author: blogItem.author,
                    image: blogItem.image
                  )));
                },
              );
            }
          //               buildBlog(
          //             title:
          //                 'Thực hành không rác thải - Chúng ta đã thực sự hiểu?',
          //             thumbnail: 'https://picsum.photos/${itemIndex + 400}',
          //             author: 'Anonymous',
          //             date: 'Jan 1, 2022',
          //             readTime: '${itemIndex + 1}',
          // )
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        buildSection(
          title: 'Products',
          body: GridView.builder(
            itemCount: productslist.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.52,
            ),
            itemBuilder: (context, index) {
              ProductModel prodItem = productslist[index];
              return ProductWidget(prodname: prodItem.prodname, description: prodItem.description, seller: prodItem.seller, price: prodItem.price, image: prodItem.image);
            } 
            // buildProduct(
            //           name: 'Bình hoa treo tường làm từ chai nhựa',
            //           image: 'https://picsum.photos/${index + 300}',
            //           price: '${24 + index},${index}00',
            //         ),
          ),
        ),
      ]);
            // ),
    //       ),
    //     ),
    //   ),
    // );
  }

  // Column buildProduct({
  //   required String name,
  //   required String image,
  //   required String price,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Stack(
  //         children: [
  //           AspectRatio(
  //             aspectRatio: 1,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(16),
  //               child: Image(
  //                 image: NetworkImage(
  //                   image,
  //                 ),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       ),
  //       Text(
  //         name,
  //         style: const TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         maxLines: 2,
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //       const SizedBox(
  //         height: 4,
  //       ),
  //       Text(
  //         '$price VND',
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.green,
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 16,
  //       ),
  //       SizedBox(
  //         width: double.infinity,
  //         height: 40,
  //         child: ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: appTheme.gray50,
  //             shadowColor: Colors.transparent,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //           child: Text(
  //             'Buy',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.black.withOpacity(0.6),
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Column buildSection({
    required String title,
    void Function()? onSeeAll,
    required Widget body,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
            InkWell(
              onTap: onSeeAll,
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        body,
      ],
    );
  }

  Widget buildTutorial({
    required String title,
    required String thumbnail,
    required String duration,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      width: double.infinity,
                      image: NetworkImage(thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Icon(
                  Icons.play_circle,
                  size: 44,
                  color: Colors.white.withOpacity(0.5),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 12,
                  right: 8,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlog({
    required String title,
    required String thumbnail,
    required String author,
    required String date,
    required String readTime,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    width: double.infinity,
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const Text(
                      'Read Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'By $author  •  $date  •  $readTime min read',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
