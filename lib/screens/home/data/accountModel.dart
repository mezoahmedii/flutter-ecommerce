class AccountModel {
  int? id;
  String? name;
  String? image;

  AccountModel.fromJson(json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
