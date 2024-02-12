import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/navigation_menu.dart';
import 'package:smartresource/presentation/home_screen/widgets/product_widget.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/providers/blogs_provider.dart';
import 'package:smartresource/providers/tutorials_provider.dart';
import 'package:smartresource/providers/products_provider.dart';
import 'package:smartresource/widgets/search_bar.dart';

import 'widgets/blog_widget.dart';
import 'widgets/tutorials_widget.dart';
import "dart:developer" as devtools show log;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyAuthProvider>(context).user;
    final tutorials =Provider.of<TutorialsProvider>(context).tutorials.take(10).toList();
    final blogs = Provider.of<BlogsProvider>(context).blogs.take(10).toList();
    final products = Provider.of<ProductsProvider>(context).products.toList();

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
                          builder: (context) => const NavigationMenu(
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
                  if (blogs.isNotEmpty)
                    buildSection(
                      title: 'Blogs',
                      onSeeAll: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationMenu(
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
                        itemCount: blogs.length,
                        itemBuilder: (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) {
                          BlogModel blogItem = blogs[itemIndex];
                          return BlogWidget(
                            blog: blogItem,
                          );
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 32,
                  ),
                  if (products.isNotEmpty)
                    buildSection(
                      title: 'Products',
                      onSeeAll: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationMenu(
                            initialPage: 3,
                          ),
                        ),
                      ),
                      body: GridView.builder(
                        itemCount: products.length,
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
                          ProductModel product = products[index];
                          return ProductWidget(product: product,);
                          // ProductModel prodItem = productslist[index];
                          // return ProductWidget(
                          //   prodname: prodItem.prodname,
                          //   description: prodItem.description,
                          //   seller: prodItem.userEmail,
                          //   price: prodItem.price,
                          //   image: prodItem.images[0],
                          // );
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
