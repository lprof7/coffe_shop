import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:coffee_shop_app/controller/user_space/pages/home_page_controller.dart';
import 'package:coffee_shop_app/model/product.dart';
import 'package:get/get.dart';

class Favorite_Controller extends GetxController {
  final Home_page_controller _controller = Get.put(Home_page_controller());

  List<Product?> favorit = [];
  bool exist(Product? product) {
    for (var element in favorit) {
      if (element == product) {
        update();
        return true;
      }
    }
    update();
    return false;
  }
}
