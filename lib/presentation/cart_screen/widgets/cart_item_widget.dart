import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/local_storage/cart_storage.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/providers/auth_provider.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatefulWidget {
  final ProductModel product;
  Function() deleteOne;
  Function() addOne;
  Function() deleteAll;
  CartItemWidget({super.key, required this.product, required this.addOne, required this.deleteOne, required this.deleteAll});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int sliderIndex = 0;
  List<String> cartItems = [];
  int ?itemQuantity;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  
  @override
  void initState() {
    super.initState();
    // Initialize data asynchronously
    initData();
  }

  Future<void> initData() async {
    // Assuming `initStorage` returns List<String>
    cartItems = await initStorage(userId);
    // Assuming `countItem` calculates the quantity of the product
    itemQuantity = countItem(cartItems, userId, widget.product.id);
    // Update the state after fetching data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: widget.product.images[0],
            height: 127.adaptSize,
            width: 127.adaptSize,
            radius: BorderRadius.circular(
              8.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 33.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 224.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By: ",
                              style: CustomTextStyles.bodySmallff495057,
                            ),
                            TextSpan(
                              text: widget.product.userEmail,
                              style: CustomTextStyles.bodySmallff6c757d,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.product.createdAt)),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.v),
                Text(
                  widget.product.prodname,
                  style: CustomTextStyles.titleSmallSemiBold,
                ),
                SizedBox(height: 9.v),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                          // "24,000đ",
                      NumberFormat.currency(locale: 'vi-VN').format(double.parse(widget.product.price)),
                      style: CustomTextStyles.titleMediumPrimary,
                    ),
                    Row(       // alignment: Alignment.topRight,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 15.h),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: widget.deleteOne,
                            child: const Icon(Icons.remove, color: Color.fromARGB(255, 181, 85, 85)),
                          ),
                        ),
                        SizedBox(width: 15.h),
                        Text(
                          '$itemQuantity',
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(width: 15.h),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: widget.addOne,
                            child: const Icon(Icons.add, color: Color.fromARGB(255, 181, 85, 85)),
                          ),
                        )
                      ]
                    ),
                  ]
                ),
                SizedBox(height: 8.v),
                IconButton(
                  onPressed: widget.deleteAll,
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
