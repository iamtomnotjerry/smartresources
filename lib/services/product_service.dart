import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/data/models/product/product_model.dart';

class ProductService {
  final firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel data) async {
    await firestore.collection('products').doc(data.id).set(data.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    final products = await firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return products.docs.map((product) => ProductModel.fromMap(product.data())).toList();
  }

  Future<List<ProductModel>> getProductWithPagination({
    int page = 1,
    int limit = 10,
    String? lastVisisbleId,
  }) async {
    var query = await firestore.collection('products').orderBy('createdAt', descending: true);

    if (lastVisisbleId != null) {
      final lastVisibleSnapshot = await firestore.collection('products').doc(lastVisisbleId).get();
      query = query.startAfterDocument(lastVisibleSnapshot);
    }

    query = await query.limit(limit);

    final products = await query.get();

    return products.docs.map((product) => ProductModel.fromMap(product.data())).toList();
  }

  Future<void> updateProduct(ProductModel data) async {
    await firestore.collection('products').doc(data.id).update(data.toJson());
  }
}