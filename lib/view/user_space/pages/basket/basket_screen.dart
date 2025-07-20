// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_shop_app/model/demande.dart';

class Basket_screen extends StatelessWidget {
  const Basket_screen({super.key});

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    final Basket_controller _controller = Get.put(Basket_controller());

    Widget DemandeCard(Demande demande, int index) {
      double itemheight = ScreenHeight * 0.5;
      double itemwidth = ScreenWidth;
      double price1 = demande.product!.getPrice1();
      double price2 = demande.product!.getPrice2();
      double price3 = demande.product!.getPrice3();
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
        child: Dismissible(
          key: ValueKey(demande.product!.getName() + index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 24),
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white, size: 32),
          ),
          confirmDismiss: (_) async {
            return await Get.dialog(
              AlertDialog(
                title: Text('Remove Item'),
                content: Text(
                    'Are you sure you want to remove this item from the basket?'),
                actions: [
                  TextButton(
                      onPressed: () => Get.back(result: false),
                      child: Text('No')),
                  ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) {
            _controller.Basket.removeAt(index);
            _controller.sumOfProducts();
            Get.snackbar('Removed', 'Item removed from basket',
                backgroundColor: Colors.red, colorText: Colors.white);
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: itemwidth * 0.35,
                          height: itemwidth * 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              demande.product!.getImgUrl(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey,
                                child: Icon(Icons.broken_image,
                                    color: Colors.white, size: 48),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: SizedBox(
                                height: itemheight * 0.2,
                                child: Text(
                                  demande.product!.getName(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                demande.product!.getProperty(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Container(
                                  height: ScreenHeight * 0.06,
                                  width: ScreenWidth * 0.34,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 27, 27, 27),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Meduim Roasted",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // التحكم في الكمية لكل حجم
                  for (int i = 0; i < 3; i++)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: itemheight * 0.13,
                                width: itemwidth * 0.22,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 27, 27, 27),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    alignment: Alignment.center,
                                    child: demande.productType == 0
                                        ? Text(
                                            i == 0
                                                ? "250gm"
                                                : i == 1
                                                    ? "500gm"
                                                    : "1000gm",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Text(
                                            i == 0
                                                ? "S"
                                                : i == 1
                                                    ? "M"
                                                    : "L",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          )),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.attach_money,
                                  size: 20,
                                  color: Color.fromARGB(255, 209, 121, 66)),
                              Text(
                                i == 0
                                    ? price1.toString()
                                    : i == 1
                                        ? price2.toString()
                                        : price3.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  var q = i == 0
                                      ? demande.quantity1
                                      : i == 1
                                          ? demande.quantity2
                                          : demande.quantity3;
                                  if (q.value > 0) q.value--;
                                  _controller.sumOfProducts();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 209, 121, 66),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: ScreenWidth * 0.08,
                                  width: ScreenWidth * 0.08,
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    Icons.remove,
                                  ),
                                ),
                              ),
                              Obx(() => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: SizedBox(
                                      height: itemheight * 0.11,
                                      width: itemwidth * 0.16,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 27, 27, 27),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66),
                                                  width: 1)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            (i == 0
                                                    ? demande.quantity1.value
                                                    : i == 1
                                                        ? demande
                                                            .quantity2.value
                                                        : demande
                                                            .quantity3.value)
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          )),
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  var q = i == 0
                                      ? demande.quantity1
                                      : i == 1
                                          ? demande.quantity2
                                          : demande.quantity3;
                                  q.value++;
                                  _controller.sumOfProducts();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 209, 121, 66),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: ScreenWidth * 0.08,
                                  width: ScreenWidth * 0.08,
                                  child: Icon(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: Column(
        children: [
          SizedBox(height: ScreenHeight * 0.08),
          Expanded(
            child: _controller.Basket.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            color: Colors.grey, size: 64),
                        SizedBox(height: 16),
                        Text('Your basket is empty!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                    child: ListView.builder(
                      itemCount: _controller.Basket.length,
                      itemBuilder: (context, index) =>
                          DemandeCard(_controller.Basket[index], index),
                    ),
                  ),
          ),
          if (_controller.Basket.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          "Total Price",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          children: [
                            Obx(
                              () => Text(
                                  (_controller.sum.value)
                                      .toPrecision(3)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.attach_money,
                                  color: Color.fromARGB(255, 209, 121, 66)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      _controller.Basket.clear();
                      _controller.sumOfProducts();
                      Get.snackbar('Basket Cleared', 'All items removed',
                          backgroundColor: Colors.red, colorText: Colors.white);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Clear Basket'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 209, 121, 66)),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // منطق إتمام الطلب (يمكنك ربطه بإضافة الطلبات)
                      Get.snackbar('Order Placed',
                          'Your order has been placed successfully!',
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                      _controller.Basket.clear();
                      _controller.sumOfProducts();
                    },
                    icon: Icon(Icons.check_circle),
                    label: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 209, 121, 66)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
