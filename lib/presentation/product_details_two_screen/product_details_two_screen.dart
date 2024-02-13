
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:smartresource/data/local_storage/cart_storage.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/services/product_service.dart';

import '../product_details_two_screen/widgets/thirtyfour_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';

enum MenuAction {delete_prod}
class ProductDetailsTwoScreen extends StatefulWidget {
  int sliderIndex = 1;
  
  final ProductModel product;

  User? currentUser = FirebaseAuth.instance.currentUser;

  ProductDetailsTwoScreen({super.key, required this.product});

  @override
  _ProductDetailsTwoScreenState createState() => _ProductDetailsTwoScreenState();
}

class _ProductDetailsTwoScreenState extends State<ProductDetailsTwoScreen> {
  int quantity = 1;
  
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(
            "Seller: ${widget.product.userEmail}",
            style: TextStyle(
              color: theme.colorScheme.primary,
            ),
          ),
          actions: [
            if (widget.currentUser?.email == widget.product.userEmail)
              PopupMenuButton<MenuAction>(
                onSelected: (value) async{
                  switch(value) {
                    case MenuAction.delete_prod:
                      final shouldDelete = await showDeleteDialog(context);
                      if (shouldDelete) {
                        await ProductService().deleteProduct(widget.product.id);
                        Navigator.of(context).pop();
                      }
                  }
                }, 
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem<MenuAction>(
                      value: MenuAction.delete_prod, 
                      child: Text('Delete Product')
                    ),
                  ];
                },
              ),
          ],
          centerTitle: true,
        ),
        // _buildAppBar(context),
        body: SingleChildScrollView(child:Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 3.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettings(context),
              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.only(left: 11.h),
                child: Text(
                  // "Đèn trang trí làm bằng chai nhựa",
                  widget.product.prodname,
                  style: CustomTextStyles.titleLargeBluegray7000123,
                ),
              ),
              Center(child: Text(
                DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.product.createdAt)),
                style: theme.textTheme.bodySmall,
              ),),
              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Text(
                  "Description",
                  style: CustomTextStyles.titleMedium18,
                ),
              ),
              SizedBox(height: 12.v),
              Container(
                width: 382.h,
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                child: Text(
                  // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus suscipit augue sit amet suscipit.\nSed sollicitudin mauris et eros imperdiet ullamcorper.\nAliquam risus metus, maximus eu mauris vel, gravida vulputate velit.\nNullam in mi dictum, dictum libero sed, auctor nunc. Sed ut tincidunt augue, eget convallis sapien. Ut fringilla volutpat finibus.",
                  widget.product.description,
                  maxLines: 11,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyles.bodyLargeBluegray70001.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 58.v),
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: EdgeInsets.only(right: 9.h),
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyle.circleBorder22,
                  ),
                  child: Container(
                    height: 44.adaptSize,
                    width: 150.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 10.v,
                    ),
                    decoration: AppDecoration.outlineBlack900.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder22,
                    ),
                    child: Row(
                      // alignment: Alignment.topRight,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 15.h),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: decrementQuantity,
                            child: const Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 15.h),
                        Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 15.h),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: incrementQuantity,
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        )),
        bottomNavigationBar: _buildBottomNavigation(context),
      );
  }

  Future<bool> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to delete your product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ]
        );
      },
    ).then((value) => value ?? false);
  }

  /// Section Widget
  Widget _buildSettings(BuildContext context) {
    return Container(
      height: 259.v,
      width: 397.h,
      margin: EdgeInsets.only(left: 3.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 260.v,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index,reason,) {
                widget.sliderIndex = index;
              },
            ),
            itemCount: widget.product.images.length,
            itemBuilder: (context, index, realIndex) {
              widget.sliderIndex = index;
              return ThirtyfourItemWidget(image: widget.product.images[index]);
            },
          ),
          // ThirtyfourItemWidget(image: widget.image),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 36.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: CustomTextStyles.titleSmallBluegray200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    // "24,000đ",
                    NumberFormat.currency(locale: 'vi-VN').format(double.parse(widget.product.price)),
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            onPressed: () {addToCart(context, widget.currentUser!.uid, widget.product.id, quantity);},
            height: 44.v,
            width: 150.h,
            text: "Add to cart",
            leftIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: const Icon(Icons.shopping_cart, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
