import 'package:flutter/material.dart';
import 'package:smartresource/data/models/product/product_model.dart';
import 'package:smartresource/services/product_service.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> products = [];

  void refreshProducts() async {
    products = await ProductService().getProducts();
    notifyListeners();
  }
}