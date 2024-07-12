class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  num? price;
  num? oldPrice;
  num? discount;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
  }
}
