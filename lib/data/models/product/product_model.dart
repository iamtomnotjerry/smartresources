class ProductModel {
  final String prodname;
  final String description;
  final String userEmail;
  final String price;
  final List<String> images;
  final String id;
  final String createdAt;

  ProductModel({
    required this.prodname,
    required this.description,
    required this.userEmail,
    required this.price,
    required this.images,
    required this.id,
    required this.createdAt,
});

  Map<String, dynamic> toJson() {
    return {
      'prodname': prodname,
      'description': description,
      'userEmail': userEmail,
      'price': price,
      'images': images,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      prodname: json['prodname'],
      description: json['description'],
      userEmail: json['userEmail'],
      price: json['price'],
      images: List<String>.from(json['images']),
      id: json['id'],
      createdAt: json['createdAt']
    );
  }
}
