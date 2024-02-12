class CartProductModel {
  final String prodname;
  final String seller;
  final String image;
  final String createdAt;
  final String price;
  final String prodid;
  final int quantity;

  CartProductModel({
    required this.prodname, 
    required this.seller, 
    required this.image,
    required this.createdAt, 
    required this.price, 
    required this.prodid,
    required this.quantity
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     "prodname": prodname,
  //     "seller": seller,
  //     "images": images,
  //     "createdAt": createdAt,
  //     "price": price,
  //     "prodid": prodid,
  //     "quantity": quantity.toString(),
  //   };
  // }

  List<String> toList() {
    return [
      prodname,
      seller,
      image,
      createdAt,
      price,
      prodid,
      quantity.toString(),
    ];
  }

  // factory CartProductModel.fromMap(Map<String, dynamic> json) {
  //   return CartProductModel(
  //     prodname: json["prodname"],
  //     seller: json["seller"],
  //     price: json["price"],
  //     images: List<String>.from(json["images"]),
  //     prodid: json["prodid"],
  //     createdAt: json["createdAt"],
  //     quantity: json["quantity"],
  //   );
  // }

  factory CartProductModel.fromList(List<String> json) {
    return CartProductModel(
      prodname: json[0],
      seller: json[1],
      image: json[2],
      createdAt: json[3],
      price: json[4],
      prodid: json[5],
      quantity: int.parse(json[6]),
    );
  }
}