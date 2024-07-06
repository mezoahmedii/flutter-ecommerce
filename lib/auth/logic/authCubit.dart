import 'dart:convert';

import 'package:ecommerce/auth/logic/authStates.dart';
import 'package:ecommerce/core/utils/constants/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInit());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String status = "";

  Future<void> signIn() async {
    emit(AuthLoading());

    var url = Uri.parse("${baseUrl}login");
    Map<String, dynamic> data = {
      "email": emailController.text,
      "password": passwordController.text
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "lang": "ar"
    };
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully logged in:");
        debugPrint(result.toString());
        status = "Successfully logged in: ${result["message"]}";
        emit(AuthSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't log in:");
        debugPrint(result.toString());
        status = "Can't log in: ${result["message"]}";
        emit(AuthError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        status = "Connection error: ${response.statusCode}";
        emit(AuthError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      status = "Error: $e";
      emit(AuthError());
    }
  }
  Future<void> signUp() async {
    emit(AuthLoading());

    var url = Uri.parse("${baseUrl}register");
    Map<String, dynamic> data = {
      "name": usernameController.text,
      "phone": phoneNumberController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "image": ""
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "lang": "ar"
    };
    try {
      final response =
          await http.post(url, body: json.encode(data), headers: headers);
      var result = json.decode(response.body);
      if (response.statusCode == 200 && result["status"] == true) {
        debugPrint("Successfully logged in:");
        debugPrint(result.toString());
        status = "Successfully logged in: ${result["message"]}";
        emit(AuthSuccess());
      } else if (result["status"] == false) {
        debugPrint("Can't log in:");
        debugPrint(result.toString());
        status = "Can't log in: ${result["message"]}";
        emit(AuthError());
      } else {
        debugPrint("Connection error:");
        debugPrint(response.statusCode.toString());
        status = "Connection error: ${response.statusCode}";
        emit(AuthError());
      }
    } catch (e) {
      debugPrint("Error:");
      debugPrint(e.toString());
      status = "Error: $e";
      emit(AuthError());
    }
  }
}
