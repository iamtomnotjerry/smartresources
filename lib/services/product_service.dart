import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/data/models/product/product_model.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel data) async {
    await _firestore.collection('products').doc(data.id).set(data.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    final products = await _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return products.docs.map((product) => ProductModel.fromMap(product.data())).toList();
  }

  Future<ProductModel> getProductById(String id) async {
    final productSnapshot = await FirebaseFirestore.instance.collection('products').doc(id).get();
    if (productSnapshot.exists) {
      return ProductModel.fromMap(productSnapshot.data()!);
    } else {
      throw Exception('Product with id $id not found');
    }
  }

  Future<List<ProductModel>> getProductWithPagination({
    int page = 1,
    int limit = 10,
    String? lastVisisbleId,
  }) async {
    var query = _firestore.collection('products').orderBy('createdAt', descending: true);

    if (lastVisisbleId != null) {
      final lastVisibleSnapshot = await _firestore.collection('products').doc(lastVisisbleId).get();
      query = query.startAfterDocument(lastVisibleSnapshot);
    }

    query = query.limit(limit);

    final products = await query.get();

    return products.docs.map((product) => ProductModel.fromMap(product.data())).toList();
  }

  Future<List<ProductModel>>searchProducts(String searchTerm) async{
    var query = _firestore.collection('products').orderBy('prodname', descending: true);
    query = query.where('prodname', isGreaterThanOrEqualTo: searchTerm);
    query = query.where('prodname', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    final products = await query.get();
    return products.docs.map((product) => ProductModel.fromMap(product.data())).toList();
  }

  Future<void> updateProduct(ProductModel data) async {
    await _firestore.collection('products').doc(data.id).update(data.toJson());
  }

  Future<void> deleteProduct(String prodid) async {
    await _firestore.collection('products').doc(prodid).delete();
  }
}