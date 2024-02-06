import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/blog/blog_source.dart';
import 'package:smartresource/data/data_sources/product/product_source.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/navigation_menu.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/providers/tutorials_provider.dart';
import 'package:smartresource/widgets/search_bar.dart';

import 'widgets/blog_widget.dart';
import 'widgets/product_widget.dart';
import 'widgets/tutorials_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyAuthProvider>(context).user;
    final tutorials =
        Provider.of<TutorialsProvider>(context).tutorials.take(10).toList();

    return SafeArea(
        child: Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                              text: user.name,
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
                  const SearchBar(),
                  const SizedBox(
                    height: 32,
                  ),
                  if (tutorials.isNotEmpty)
                    buildSection(
                      title: 'Tutorials',
                      onSeeAll: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationMenu(
                            initialPage: 1,
                          ),
                        ),
                      ),
                      body: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          aspectRatio: 1.3,
                        ),
                        itemCount: tutorials.length,
                        itemBuilder: (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) {
                          TutorialModel tutorialItem = tutorials[itemIndex];
                          return TutorialWidget(
                            videoId: tutorialItem.videoId,
                            title: tutorialItem.title,
                            materials: tutorialItem.materials,
                            instructions: tutorialItem.instructions,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TutorialDetailsScreen(
                                    tutorial: tutorialItem,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 32,
                  ),
                  buildSection(
                    title: 'Blogs',
                    onSeeAll: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationMenu(
                          initialPage: 2,
                        ),
                      ),
                    ),
                    body: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          aspectRatio: 1.2,
                        ),
                        itemCount: blogList.length,
                        itemBuilder: (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) {
                          BlogModel blogItem = blogList[itemIndex];
                          return BlogWidget(
                            title: blogItem.title,
                            image: blogItem.image,
                            content: blogItem.content,
                            author: blogItem.author,
                            date: 'Jan 1, 2022',
                            readTime: '${itemIndex + 1}',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogDetailsScreen(
                                    title: blogItem.title,
                                    content: blogItem.content,
                                    author: blogItem.author,
                                    image: blogItem.image,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  buildSection(
                    title: 'Products',
                    onSeeAll: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationMenu(
                          initialPage: 3,
                        ),
                      ),
                    ),
                    body: GridView.builder(
                      itemCount: productslist.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.52,
                      ),
                      itemBuilder: (context, index) {
                        ProductModel prodItem = productslist[index];
                        return ProductWidget(
                          prodname: prodItem.prodname,
                          description: prodItem.description,
                          seller: prodItem.seller,
                          price: prodItem.price,
                          image: prodItem.image[0],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
    ));
  }

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
}
