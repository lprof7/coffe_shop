import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:coffee_shop_app/view/user_space/pages/home_page/home_page_screen.dart';
import 'package:coffee_shop_app/view/user_space/user_space.dart';

class LoginController extends GetxController {
  var _email = "".obs;
  var _password = "".obs;

  void setEmail(String value) {
    this._email.value = value;
  }

  void setPassword(String value) {
    this._password.value = value;
  }

  String getEmail() {
    return this._email.value;
  }

  String getPassword() {
    return this._password.value;
  }

  Future<void> login(String email, String password, context) async {
    // Mock data for demonstration
    const mockEmail = 'demo@demo.com';
    const mockPassword = '123456';

    await Future.delayed(Duration(milliseconds: 500)); // Simulate API call

    if (email == mockEmail && password == mockPassword) {
      Get.snackbar(
        'Success',
        'Logged in successfully',
        backgroundColor: Color.fromARGB(255, 209, 121, 66),
        colorText: Colors.white,
      );

      // Navigate to home page after successful login
      await Future.delayed(
        Duration(milliseconds: 1000),
      ); // Short delay to show message
      Get.offAll(
        () => User_space_screen(),
      ); // Navigate and remove previous pages
    } else if (email != mockEmail) {
      Get.snackbar(
        'Error',
        'Account not found',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password != mockPassword) {
      Get.snackbar(
        'Error',
        'Wrong password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
