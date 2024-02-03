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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 170.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: image,
            height: 134.v,
            width: 170.h,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          SizedBox(height: 9.v),
          SizedBox(
            width: 170.h,
            child: Text(
              prodname,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: theme.textTheme.titleSmall!.copyWith(
                height: 1.14,
              ),
            ),
          ),
          SizedBox(height: 2.v),
          Text(
            "24,000đ",
            style: theme.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
