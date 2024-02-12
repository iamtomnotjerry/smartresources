import 'dart:async';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartresource/data/local_storage/cart_storage.dart';
import 'package:smartresource/data/models/product/product_model.dart';

import 'widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'dart:developer' as devtools show log;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 0;

  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cart_items', []);
    initData();
    setState(() {}); // This clears all key-value pairs from SharedPreferences
  }

  void deleteOneProduct(String prodid) {
    deleteFirstOccurrence(prodid);
    initData();
    setState(() {});
  }

  void deleteDuplicateProduct(String prodid) {
    deleteAllOccurrences(prodid);
    initData();
    setState(() {});
  }

  void addOneProduct(String prodid) {
    addToCart(context, prodid, 1);
    initData();
    setState(() {});
  }

  @override 
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async{
    total = await calculateTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Cart",
            style: theme.textTheme.titleLarge,
          ),
          actions: [
            TextButton(onPressed: () {clearStorage();}, child: const Text("Empty your cart")),
          ]
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 24.h,
            top: 61.v,
            right: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfileSection(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationSection(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileSection(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 1.h),
        decoration: AppDecoration.outlineBlack,
        child: 
        FutureBuilder<List<ProductModel>>(
          future: retrieveItemsFromStorage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
            }

            if (snapshot.hasError) {
              devtools.log(snapshot.error.toString());
              Center(child: Text("Your cart is empty", style: theme.textTheme.titleLarge),);
            }

            List<ProductModel>  items = snapshot.data ?? [];

            if (items.isNotEmpty) {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(
                    product: items[index],
                    addOne: () {addOneProduct(items[index].id);}, 
                    deleteOne: () {deleteOneProduct(items[index].id);},
                    deleteAll: () {deleteDuplicateProduct(items[index].id);},
                  );
                },
              );
            }

            return Center(child: Text("Your cart is empty", style: theme.textTheme.titleLarge),);
          },
        )
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 34.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Container(
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style: CustomTextStyles.titleSmallBluegray200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    NumberFormat.currency(locale: 'vi-VN').format(total),
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              height: 44.v,
              width: 175.h,
              text: "Buy Now",
            ),
          ],
        ),
      ),
    );
  }
}
