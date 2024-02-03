import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';

// ignore: must_be_immutable
class BlogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;
  final String date;
  final String readTime;
  Function() ? onTap;

  BlogWidget({super.key, required this.title, required this.image, required this.content, required this.author, required this.date, required this.readTime, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: () {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailsScreen(
    //       title: title,
    //       content: content,
    //       author: author,
    //       image: image
    //     )));
    //   },
    //   child:SizedBox(
    //   width: 170.h,
    //   child: Padding(
    //     padding: EdgeInsets.only(bottom: 1.v),
    //     child: Column(
    //       children: [
    //         CustomImageView(
    //           imagePath: image,
    //           height: 134.v,
    //           width: 170.h,
    //           radius: BorderRadius.circular(
    //             10.h,
    //           ),
    //         ),
    //         SizedBox(height: 9.v),
    //         SizedBox(
    //           width: 170.h,
    //           child: Text(
    //             // "Lorem ipsum dolor sit amet, consectetur adipiscing",
    //             title,
    //             maxLines: 3,
    //             overflow: TextOverflow.ellipsis,
    //             textAlign: TextAlign.justify,
    //             style: theme.textTheme.titleSmall!.copyWith(
    //               height: 1.14,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ));
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
                    image: NetworkImage(image),
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
