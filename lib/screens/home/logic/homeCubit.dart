import 'dart:convert';

import 'package:ecommerce/core/utils/cache/sharedPrefs.dart';
import 'package:ecommerce/core/utils/constants/apiConstants.dart';
import 'package:ecommerce/screens/home/data/accountModel.dart';
import 'package:ecommerce/screens/home/data/bannerModel.dart';
import 'package:ecommerce/screens/home/data/categoryModel.dart';
import 'package:ecommerce/screens/home/data/productModel.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInit());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  ProductModel currentProduct = ProductModel.fromJson({});
  List<BannerModel> banners = [];
  List<ProductModel> favorites = [];
  List<ProductModel> cart = [];
  AccountModel currentAccount = AccountModel.fromJson({});

  Future<void> getCategories(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}categories");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten categories:");
        debugPrint(result.toString());
        result["data"]["data"].forEach((category) {
          categories.add(CategoryModel.fromJson(category));
        });
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get categories:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> getProducts(context, id) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}products?category_id=$id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten products:");
        debugPrint(result.toString());
        result["data"]["data"].forEach((product) {
          products.add(ProductModel.fromJson(product));
        });
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get products:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> getProductInfo(context, id) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}products/$id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten product info:");
        debugPrint(result.toString());
        currentProduct = ProductModel.fromJson(result["data"]);
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get product info:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> getBanners(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}banners");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten banners:");
        debugPrint(result.toString());
        result["data"].forEach((banner) {
          banners.add(BannerModel.fromJson(banner));
        });
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get banners:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> addFavorite(context, id) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}favorites");
    Map<String, dynamic> data = {"product_id": id};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully added favorite: ${result["message"]}");
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        Navigator.popAndPushNamed(context, "/homeScreen");
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't add favorite: ${result["message"]}");
        emit(HomeError());
      } else {
        debugPrint("Connection error: ${response.statusCode}");
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error: $e");
      emit(HomeError());
    }
  }

  Future<void> addToCart(context, id) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}carts");
    Map<String, dynamic> data = {"product_id": id};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully added to cart: ${result["message"]}");
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        Navigator.popAndPushNamed(context, "/cartScreen");
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't add to cart: ${result["message"]}");
        emit(HomeError());
      } else {
        debugPrint("Connection error: ${response.statusCode}");
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error: $e");
      emit(HomeError());
    }
  }

  Future<void> getFavorites(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}favorites");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten favorites:");
        debugPrint(result.toString());
        result["data"]["data"].forEach((product) {
          favorites.add(ProductModel.fromJson(product["product"]));
        });
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get favorites:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> getCart(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}carts");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten cart:");
        debugPrint(result.toString());
        result["data"]["cart_items"].forEach((product) {
          cart.add(ProductModel.fromJson(product["product"]));
        });
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get cart:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }

  Future<void> getAccount(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}profile");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": SharedPrefs.prefs.getString("token")!,
      "lang": lang
    };
    try {
      final response = await http.get(url, headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully gotten account info:");
        debugPrint(result.toString());
        currentAccount = AccountModel.fromJson(result["data"]);
        emit(HomeSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't get account info:");
        debugPrint(result.toString());
        emit(HomeError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        emit(HomeError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      emit(HomeError());
    }
  }
}
