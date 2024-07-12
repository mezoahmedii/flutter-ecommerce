class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  num? price;
  num? oldPrice;
  num? discount;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
