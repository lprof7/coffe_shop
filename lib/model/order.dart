import 'package:coffee_shop_app/model/demande.dart';

class Order {
  Order(this.demandes);
  List<Demande> demandes = [];
  double? order_price;
}
