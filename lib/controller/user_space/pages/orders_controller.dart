import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:coffee_shop_app/model/order.dart';
import 'package:get/get.dart';

final Basket_controller _basketController = Get.put(Basket_controller());

class Order_controller extends GetxController {
  List<Order> orders = [Order(_basketController.Basket)];
}
