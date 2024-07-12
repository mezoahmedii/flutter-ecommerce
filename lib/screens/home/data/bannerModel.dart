class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(json) {
    id = json["id"];
    image = json["image"];
  }
}