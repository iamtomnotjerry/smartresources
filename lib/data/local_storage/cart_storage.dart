import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:developer" as devtools show log;

import 'package:smartresource/services/product_service.dart';
import 'package:smartresource/data/models/product/product_model.dart';

Future<List<String>> initStorage() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList('cart_items') ?? [];
  return cartItems;
}

void addToCart(BuildContext context, String prodid, int quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList('cart_items') ?? [];
  
  for (var i = 0; i < quantity; i++) {
    devtools.log(prodid);
      // Add the serialized product and quantity to the cart items list
    cartItems.add(prodid);
  }
    
    // Save the updated cart items list to local storage
  prefs.setStringList('cart_items', cartItems);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Product added.'),
    ),
  );
}

Future<List<ProductModel>> retrieveItemsFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cartItems = prefs.getStringList('cart_items');
  List<String> uniqueItems = cartItems!.toSet().toList();
  List<ProductModel> items = [];
  for (String cartItem in uniqueItems) {
    try {
      ProductModel itemToAdd = await ProductService().getProductById(cartItem);
      items.add(itemToAdd);
    } catch (e) {
      devtools.log(cartItem);
      devtools.log('Error decoding JSON: $e');
    }
  }
  devtools.log(items.toString());
  return items;
}

Future<double> calculateTotal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cartItems = prefs.getStringList('cart_items');
  double total = 0;
  for (String cartItem in cartItems!) {
    try {
      ProductModel product = await ProductService().getProductById(cartItem);
      total += double.parse(product.price);
    } catch (e) {
      devtools.log(cartItem);
      devtools.log('Error decoding JSON: $e');
    }
  }
  devtools.log(total.toString());
  return total;
}

int countItem(List<String> cartItems, String prodid){
  int countOfItem = cartItems.where((element) => element == prodid).length;
  return countOfItem;
}

void deleteFirstOccurrence(String prodid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList('cart_items') ?? [];
  cartItems.remove(prodid);
  prefs.setStringList('cart_items', cartItems);
}

void deleteAllOccurrences(String prodid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList('cart_items') ?? [];
  cartItems.removeWhere((prod) => prod == prodid);
  prefs.setStringList('cart_items', cartItems);
}