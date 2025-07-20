import 'package:coffee_shop_app/controller/user_space/pages/home_page_controller.dart';
import 'package:coffee_shop_app/view/user_space/pages/home_page/beans_details_screen.dart';
import 'package:coffee_shop_app/view/user_space/pages/home_page/coffe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_shop_app/model/product.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final Home_page_controller _controller = Get.put(Home_page_controller());
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading time for better UX
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget productImage(String imgUrl) {
    return Image.asset(
      imgUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, color: Colors.grey, size: 48),
    );
  }

  Widget priceRow(Product product) {
    return Row(
      children: [
        Icon(Icons.attach_money, color: Color.fromARGB(255, 209, 121, 66)),
        Text('${product.getPrice1()}',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w200)),
      ],
    );
  }

  Widget ProductCard(Product product, VoidCallback onTap) {
    double itemheight = MediaQuery.of(context).size.height * 0.36;
    double itemwidth = MediaQuery.of(context).size.width * 0.4;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: child,
        ),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            height: itemheight,
            width: itemwidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color.fromARGB(255, 39, 39, 39),
                  Color.fromARGB(255, 63, 63, 63),
                  Color.fromARGB(255, 100, 100, 100),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: itemwidth,
                    height: itemheight * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: productImage(product.getImgUrl()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.getName(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        product.getProperty(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Cairo',
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      priceRow(product),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 209, 121, 66),
              ),
            )
          : Column(
              children: [
                // Search bar section
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search for coffee...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Cairo',
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Color.fromARGB(255, 66, 66, 66),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Category filter section
                Container(
                  height: 50,
                  child: Obx(() => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _controller.categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                _controller.selectedCategory.value = index;
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: _controller.selectedCategory.value ==
                                          index
                                      ? Color.fromARGB(255, 209, 121, 66)
                                      : Color.fromARGB(255, 66, 66, 66),
                                ),
                                child: Text(
                                  _controller.categories[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ),
                SizedBox(height: 20),
                // Products grid section
                Expanded(
                  child: Obx(() {
                    var filteredProducts = _controller
                        .getFilteredProducts()
                        .where((product) => product
                            .getName()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .toList();

                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        var product = filteredProducts[index];
                        return ProductCard(product, () {
                          if (product.getType() == "Beans") {
                            Get.to(
                                () => Beans_details_screen(product: product));
                          } else {
                            Get.to(
                                () => Coffee_details_screen(product: product));
                          }
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
    );
  }
}
