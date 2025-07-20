import 'package:coffee_shop_app/model/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coffee_shop_app/view/user_space/pages/home_page/home_page_screen.dart';
import 'package:coffee_shop_app/model/mock_data.dart';

class Beans_details_controller extends GetxController {
  var quantity1 = 1.obs;
  var quantity2 = 0.obs;
  var quantity3 = 0.obs;
}

class Coffe_details_controller extends GetxController {
  var quantity1 = 1.obs;
  var quantity2 = 0.obs;
  var quantity3 = 0.obs;
}

class Home_page_controller extends GetxController {
  // Product categories for filtering
  List<String> categories = [
    "All",
    "Cappuccino",
    "Americano",
    "Espresso",
    "Mocha",
    "Latte",
    "Beans"
  ];

  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  var selectedCategory = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    allProducts = MockData.getAllProducts();
    updateFilteredProducts();
    update();
  }

  void updateFilteredProducts() {
    if (selectedCategory.value == 0) {
      // "All" category
      filteredProducts = List<Product>.from(allProducts);
    } else {
      String categoryName = categories[selectedCategory.value];
      filteredProducts = allProducts
          .where((element) => element.getType() == categoryName)
          .toList();
    }
    update();
  }

  List<Product> getFilteredProducts() {
    return filteredProducts;
  }

  Product? findProduct(String name) {
    for (var element in allProducts) {
      if (element.getName() == name) {
        return element;
      }
    }
    return null;
  }

  Product? selectedProduct = Product(
      "Cappuccino Classic",
      "Rich and creamy with foam",
      "Cappuccino",
      "A delicious cappuccino with rich foam and steamed milk, often with a sprinkle of cocoa powder or cinnamon on top",
      4.5,
      6.0,
      7.5,
      "images/login/1.png");

  int milk = 0;
}
