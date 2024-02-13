import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:developer" as devtools show log;

import 'package:smartresource/services/product_service.dart';
import 'package:smartresource/data/models/product/product_model.dart';

Future<List<String>> initStorage(String uid) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList(uid) ?? [];
  return cartItems;
}

void addToCart(BuildContext context, String uid, String prodid, int quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList(uid) ?? [];
  
  for (var i = 0; i < quantity; i++) {
    devtools.log(prodid);
      // Add the serialized product and quantity to the cart items list
    cartItems.add(prodid);
  }
    
    // Save the updated cart items list to local storage
  prefs.setStringList(uid, cartItems);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Product added.'),
    ),
  );
}

Future<List<ProductModel>> retrieveItemsFromStorage(String uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cartItems = prefs.getStringList(uid);
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

Future<double> calculateTotal(String uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cartItems = prefs.getStringList(uid);
  double total = 0;
  if (cartItems == null) {
    return total;
  }
  for (String cartItem in cartItems) {
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

int countItem(List<String> cartItems, String uid, String prodid){
  int countOfItem = cartItems.where((element) => element == prodid).length;
  return countOfItem;
}

void deleteFirstOccurrence(String uid, String prodid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList(uid) ?? [];
  cartItems.remove(prodid);
  prefs.setStringList(uid, cartItems);
}

void deleteAllOccurrences(String uid, String prodid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cartItems = prefs.getStringList(uid) ?? [];
  cartItems.removeWhere((prod) => prod == prodid);
  prefs.setStringList(uid, cartItems);
}