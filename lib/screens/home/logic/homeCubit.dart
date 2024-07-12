import 'dart:convert';

import 'package:ecommerce/core/utils/constants/apiConstants.dart';
import 'package:ecommerce/core/utils/constants/token.dart';
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

  Future<void> getCategories(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}categories");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": token,
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
      "Authorization": token,
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
      "Authorization": token,
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
      "Authorization": token,
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
    Map<String, dynamic> data = {
      "product_id": id
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": token,
      "lang": lang
    };
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully added favorite: ${result["message"]}");
        Navigator.pushNamed(context, "/homeScreen");
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

  Future<void> getFavorites(context) async {
    emit(HomeLoading());

    var url = Uri.parse("${baseUrl}favorites");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": token,
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
}
