// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffee_shop_app/controller/user_space/pages/favorite_controller.dart';
import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorite_screen_page extends StatefulWidget {
  const Favorite_screen_page({super.key});

  @override
  State<Favorite_screen_page> createState() => _Favorite_screen_pageState();
}

class _Favorite_screen_pageState extends State<Favorite_screen_page> {
  final Favorite_Controller _favoritcontroller = Get.put(Favorite_Controller());
  final Basket_controller _basketController = Get.put(Basket_controller());
  String searchQuery = '';
  bool isLoading = false;

  // دوال لحساب الأبعاد المتجاوبة
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  // نسب الأبعاد المحسنة
  double get cardHeight => screenHeight * 0.65; // تقليل من 0.7 إلى 0.65
  double get cardWidth => screenWidth;
  double get imageHeight => cardHeight * 0.6; // تقليل من 0.7 إلى 0.6
  double get descriptionHeight => cardHeight * 0.25; // زيادة من 0.3 إلى 0.25
  double get infoHeight => screenHeight * 0.15; // تقليل من 0.2 إلى 0.15

  // أحجام الأيقونات والزر
  double get iconSize => screenWidth * 0.08; // تقليل من 0.1 إلى 0.08
  double get buttonSize => screenWidth * 0.09; // تقليل من 0.1 إلى 0.09
  double get smallIconSize => screenWidth * 0.11; // تقليل من 0.13 إلى 0.11

  @override
  void initState() {
    super.initState();
    // محاكاة تحميل البيانات
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  // دالة البحث في المفضلة
  List<dynamic> getFilteredFavorites() {
    if (searchQuery.isEmpty) return _favoritcontroller.favorit;
    return _favoritcontroller.favorit
        .where((item) =>
            item!.getName().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  // دالة إضافة إلى السلة
  void addToBasket(dynamic item) {
    // إضافة المنتج إلى السلة (يمكن ربطه بالمنطق الحقيقي)
    Get.snackbar(
      'Added to Basket',
      '${item.getName()} added to your basket',
      backgroundColor: Color.fromARGB(255, 209, 121, 66),
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  // دالة حذف من المفضلة مع تأكيد
  void removeFromFavorites(int index) {
    Get.dialog(
      AlertDialog(
        title: Text('Remove from Favorites'),
        content:
            Text('Are you sure you want to remove this item from favorites?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _favoritcontroller.favorit.removeAt(index);
              _favoritcontroller.update();
              Get.snackbar(
                'Removed',
                'Item removed from favorites',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: Text('Remove'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget FavoriteCard(String name, String propertie, String description,
      String imgUrl, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 50 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: child,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // تحسين المسافات
        child: SizedBox(
          height: cardHeight,
          width: cardWidth,
          child: Stack(children: [
            // الصورة الرئيسية
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              child: SizedBox(
                width: cardWidth,
                height: imageHeight,
                child: Image.asset(
                  '$imgUrl',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    child:
                        Icon(Icons.broken_image, color: Colors.white, size: 48),
                  ),
                ),
              ),
            ),

            // قسم الوصف
            Positioned(
              top: imageHeight,
              child: Container(
                  height: descriptionHeight,
                  width: cardWidth - 32, // تحسين العرض
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color.fromARGB(255, 39, 39, 39),
                        Color.fromARGB(255, 63, 63, 63),
                        Color.fromARGB(255, 100, 100, 100),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20, 10, 20, 10), // تحسين المسافات
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Expanded(
                          child: Text(description,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  )),
            ),

            // معلومات المنتج
            Positioned(
              bottom: 185,
              child: Container(
                height: infoHeight,
                width: cardWidth - 32, // تحسين العرض
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, 0, 16, 8), // تحسين المسافات
                  child: Column(
                    children: [
                      // اسم المنتج والخصائص
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 18, // تقليل من 20 إلى 18
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(propertie,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 180, 180),
                                        fontFamily: 'Cairo',
                                        fontSize: 14, // تقليل من 15 إلى 14
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),

                          // أيقونة الحبوب
                          Container(
                            height: smallIconSize,
                            width: smallIconSize,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 27, 27, 27),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Image.asset("images/icons/bean.png",
                                        color:
                                            Color.fromARGB(255, 209, 121, 66)),
                                  ),
                                ),
                                Text(
                                  "Beans",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),

                          SizedBox(width: 8),

                          // أيقونة الموقع
                          Container(
                            height: smallIconSize,
                            width: smallIconSize,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 27, 27, 27),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Icon(Icons.place,
                                        color:
                                            Color.fromARGB(255, 209, 121, 66)),
                                  ),
                                ),
                                Text(
                                  "Position",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      // التقييم ونوع التحميص
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 209, 121, 66),
                            size: iconSize,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "4.5",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 18, // تقليل من 20 إلى 18
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "(1089)",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          Container(
                              height: screenHeight * 0.05, // تقليل الارتفاع
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 27, 27),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  "Medium Roasted",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            // أزرار التفاعل
            Positioned(
              right: 16,
              top: 16,
              child: Row(
                children: [
                  // زر إضافة إلى السلة
                  InkWell(
                    onTap: () => addToBasket(_favoritcontroller.favorit[index]),
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 209, 121, 66),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: buttonSize,
                      width: buttonSize,
                      child: Icon(
                        color: Colors.white,
                        Icons.shopping_cart,
                        size: iconSize,
                      ),
                    ),
                  ),

                  // زر الحذف من المفضلة
                  InkWell(
                    onTap: () => removeFromFavorites(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 100, 100, 100)),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color.fromARGB(255, 39, 39, 39),
                            Color.fromARGB(255, 100, 100, 100),
                          ],
                        ),
                      ),
                      height: buttonSize,
                      width: buttonSize,
                      child: Icon(
                        color: Colors.red,
                        Icons.favorite,
                        size: iconSize,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.06), // تقليل من 0.08 إلى 0.06

          // شريط البحث
          Padding(
            padding: const EdgeInsets.fromLTRB(
                20, 0, 20, 16), // تقليل المسافة السفلية
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Color.fromARGB(255, 180, 180, 180),
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 180, 180, 180),
                  fontFamily: 'Cairo',
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 66, 66, 66),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Color.fromARGB(255, 180, 180, 180),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
                hintText: "Search in favorites...",
              ),
            ),
          ),

          // قائمة المفضلة
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : GetBuilder<Favorite_Controller>(
                    builder: (context) {
                      final filteredFavorites = getFilteredFavorites();

                      if (filteredFavorites.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border,
                                  color: Colors.grey, size: 64),
                              SizedBox(height: 16),
                              Text(
                                searchQuery.isEmpty
                                    ? 'No favorites yet!'
                                    : 'No matching favorites found!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                searchQuery.isEmpty
                                    ? 'Your favorite items will appear here'
                                    : 'Try a different search term',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView(
                        padding:
                            EdgeInsets.only(bottom: 16), // إضافة مسافة سفلية
                        children: List.generate(
                            filteredFavorites.length,
                            (index) => FavoriteCard(
                                filteredFavorites[index]!.getName(),
                                filteredFavorites[index]!.getProperty(),
                                filteredFavorites[index]!.getDescription(),
                                filteredFavorites[index]!.getImgUrl(),
                                index)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
