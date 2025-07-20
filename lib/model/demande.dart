import 'package:coffee_shop_app/model/product.dart';
import 'package:get/get.dart';

class Demande {
  Product? product;
  int demandeIndex;
  int productType = 0;

  var quantity1 = 0.obs;
  var quantity2 = 0.obs;
  var quantity3 = 0.obs;

  Demande(
    this.product,
    int quantity1,
    int quantity2,
    int quantity3,
    this.demandeIndex,
    this.productType,
  ) {
    this.quantity1.value = quantity1;
    this.quantity2.value = quantity2;
    this.quantity3.value = quantity3;
  }
}
