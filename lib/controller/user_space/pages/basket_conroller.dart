import 'package:coffee_shop_app/controller/user_space/pages/home_page_controller.dart';
import 'package:coffee_shop_app/model/demande.dart';
import 'package:get/get.dart';
import 'package:coffee_shop_app/model/product.dart';
import 'package:coffee_shop_app/view/user_space/pages/basket/basket_screen.dart';

final Home_page_controller _controller = Get.put(Home_page_controller());

class Basket_controller extends GetxController {
  List<Demande> Basket = [];
  var sum = 0.0.obs;
  void sumOfProducts() {
    sum.value = 0;
    for (var element in Basket) {
      sum.value = sum.value +
          element.quantity1 * element.product!.getPrice1() +
          element.quantity2 * element.product!.getPrice2() +
          element.quantity3 * element.product!.getPrice3();
    }
  }

  bool elementExist(Product? product) {
    for (var element in Basket) {
      if (product == element.product) {
        return true;
      }
    }
    return false;
  }
}
