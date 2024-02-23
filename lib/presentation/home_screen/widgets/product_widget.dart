
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/local_storage/cart_storage.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/presentation/product_details_two_screen/product_details_two_screen.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final String uid;
  const ProductWidget({super.key, required this.product, required this.uid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsTwoScreen(
              product: product,
            ),
          ),
        );
      },
      child:Column(
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
                    product.images[0],
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
          product.prodname,
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
          NumberFormat.currency(locale: 'vi-VN').format(double.parse(product.price)),
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
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              addToCart(context, uid, product.id, 1);
              Navigator.pushNamed(context, AppRoutes.cartScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
    ));
  }
}
