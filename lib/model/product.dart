import 'package:get/get.dart';

class Product {
  Product(
    this._name,
    this._property,
    this._type,
    this._description,
    this._price1,
    this._price2,
    this._price3,
    this._imgUrl,
  ) {
    sumPrices.value = (_price1 + _price2 + _price3);
  }
  String _name;
  String _property;
  String _type;
  String _description;
  double _price1;
  double _price2;
  double _price3;
  String _imgUrl;
  var sumPrices = 0.0.obs;

  String getType() {
    return this._type;
  }

  String getName() {
    return this._name;
  }

  String getProperty() {
    return this._property;
  }

  String getDescription() {
    return this._description;
  }

  double getPrice1() {
    return this._price1;
  }

  double getPrice2() {
    return this._price2;
  }

  double getPrice3() {
    return this._price3;
  }

  String getImgUrl() {
    return this._imgUrl;
  }
}
