import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
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
                            text: '${user!.name}',
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
                    itemCount: 10,
                    itemBuilder: (
                      BuildContext context,
                      int itemIndex,
                      int pageViewIndex,
                    ) =>
                        buildTutorial(
                      title:
                          'Table lamp making - Plastic bottle Corner Flower vase - Lighting lamp making',
                      thumbnail: 'https://picsum.photos/${itemIndex + 500}',
                      duration: '3:0$itemIndex',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                buildSection(
                  title: 'Blogs',
                  body: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      aspectRatio: 1.2,
                    ),
                    itemCount: 10,
                    itemBuilder: (
                      BuildContext context,
                      int itemIndex,
                      int pageViewIndex,
                    ) =>
                        buildBlog(
                      title:
                          'Thực hành không rác thải - Chúng ta đã thực sự hiểu?',
                      thumbnail: 'https://picsum.photos/${itemIndex + 400}',
                      author: 'Anonymous',
                      date: 'Jan 1, 2022',
                      readTime: '${itemIndex + 1}',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                buildSection(
                  title: 'Products',
                  body: GridView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.52,
                    ),
                    itemBuilder: (context, index) => buildProduct(
                      name: 'Bình hoa treo tường làm từ chai nhựa',
                      image: 'https://picsum.photos/${index + 300}',
                      price: '${24 + index},${index}00',
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

  Column buildProduct({
    required String name,
    required String image,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '$price VND',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.gray50,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Buy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        )
      ],
    );
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
