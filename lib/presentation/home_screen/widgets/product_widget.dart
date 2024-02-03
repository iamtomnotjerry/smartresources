import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  final String prodname;
  final String description;
  final String seller;
  final double price;
  final String image;
  
  ProductWidget({super.key, required this.prodname, required this.description, required this.seller, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 10.0),
  //     width: 170.h,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
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
  //             prodname,
  //             maxLines: 3,
  //             overflow: TextOverflow.ellipsis,
  //             textAlign: TextAlign.justify,
  //             style: theme.textTheme.titleSmall!.copyWith(
  //               height: 1.14,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 2.v),
  //         Text(
  //           "24,000đ",
  //           style: theme.textTheme.labelLarge,
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
          // name,
          prodname,
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
}
