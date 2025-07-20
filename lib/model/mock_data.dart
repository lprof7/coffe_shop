import 'package:coffee_shop_app/model/product.dart';

class MockData {
  static List<Product> getAllProducts() {
    return [
      Product(
        "Cappuccino Classic",
        "Rich and creamy with foam",
        "Cappuccino",
        "A delicious cappuccino with rich foam and steamed milk, often with a sprinkle of cocoa powder or cinnamon on top",
        4.5,
        6.0,
        7.5,
        "images/login/1.png",
      ),
      Product(
        "Espresso Classic",
        "Strong and bold Italian style",
        "Espresso",
        "Classic Italian espresso shot with rich flavor and perfect crema",
        3.0,
        4.0,
        5.0,
        "images/login/2.jpg",
      ),
      Product(
        "Mocha Delight",
        "Chocolate flavored with milk",
        "Mocha",
        "Mocha with chocolate and steamed milk, topped with whipped cream",
        5.0,
        6.5,
        8.0,
        "images/login/3.png",
      ),
      Product(
        "Latte Art",
        "Smooth and creamy",
        "Latte",
        "Smooth latte with steamed milk and beautiful latte art",
        4.0,
        5.5,
        7.0,
        "images/login/4.png",
      ),
      Product(
        "Americano Bold",
        "Strong black coffee",
        "Americano",
        "Classic Americano with hot water and espresso shot",
        3.5,
        4.5,
        5.5,
        "images/login/1.png",
      ),
      Product(
        "Premium Arabica Beans",
        "High quality Arabica coffee beans",
        "Beans",
        "High quality Arabica coffee beans from Ethiopia, perfect for grinding at home",
        10.0,
        18.0,
        25.0,
        "images/login/2.jpg",
      ),
      Product(
        "Robusta Beans",
        "Strong and intense flavor",
        "Beans",
        "Robusta coffee beans with high caffeine content and intense flavor",
        8.0,
        15.0,
        22.0,
        "images/login/3.png",
      ),
      Product(
        "Colombian Beans",
        "Medium roast Colombian beans",
        "Beans",
        "Medium roast Colombian coffee beans with balanced acidity and body",
        12.0,
        20.0,
        28.0,
        "images/login/4.png",
      ),
    ];
  }

  static List<Product> getCoffeeProducts() {
    return getAllProducts()
        .where((product) => product.getType() != "Beans")
        .toList();
  }

  static List<Product> getBeanProducts() {
    return getAllProducts()
        .where((product) => product.getType() == "Beans")
        .toList();
  }

  static List<Product> getProductsByType(String type) {
    if (type == "All") {
      return getAllProducts();
    }
    return getAllProducts()
        .where((product) => product.getType() == type)
        .toList();
  }
}
