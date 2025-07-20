// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:coffee_shop_app/controller/user_space/pages/orders_controller.dart';
import 'package:coffee_shop_app/model/product.dart';
import 'package:coffee_shop_app/model/order.dart';
import 'package:coffee_shop_app/model/demande.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Orders_screen extends StatefulWidget {
  const Orders_screen({super.key});

  @override
  State<Orders_screen> createState() => _Orders_screenState();
}

class _Orders_screenState extends State<Orders_screen> {
  final Basket_controller _basketController = Get.put(Basket_controller());
  final Order_controller _orderController = Get.put(Order_controller());
  bool isLoading = false;

  Future<void> _refreshOrders() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(milliseconds: 600));
    setState(() => isLoading = false);
  }

  Widget orderStatusWidget() {
    // حالة ثابتة رمزية
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, color: Colors.orange, size: 16),
          SizedBox(width: 4),
          Text('PENDING',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget productSummary(Demande demande) {
    double price = demande.quantity1.value * demande.product!.getPrice1() +
        demande.quantity2.value * demande.product!.getPrice2() +
        demande.quantity3.value * demande.product!.getPrice3();
    int totalQty = demande.quantity1.value +
        demande.quantity2.value +
        demande.quantity3.value;
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              demande.product!.getImgUrl(),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 40,
                height: 40,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(demande.product!.getName(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Qty: $totalQty',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            '${price.toStringAsFixed(2)}',
            style: TextStyle(
                color: Color.fromARGB(255, 209, 121, 66),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget animatedOrderCard(Order order, int index) {
    double total = 0;
    for (var d in order.demandes) {
      total += d.quantity1.value * d.product!.getPrice1();
      total += d.quantity2.value * d.product!.getPrice2();
      total += d.quantity3.value * d.product!.getPrice3();
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 100)),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 50 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: child,
        ),
      ),
      child: Card(
        color: Colors.white.withOpacity(0.03),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order #${index + 1}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  orderStatusWidget(),
                ],
              ),
              SizedBox(height: 8),
              ...order.demandes.map((d) => productSummary(d)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Total: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('${total.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 209, 121, 66),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: Column(
        children: [
          SizedBox(height: ScreenHeight * 0.08),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refreshOrders,
                    child: _orderController.orders.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.receipt_long,
                                    color: Colors.grey, size: 64),
                                SizedBox(height: 16),
                                Text(
                                  'No orders yet!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Your orders will appear here',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _orderController.orders.length,
                            itemBuilder: (context, index) {
                              return animatedOrderCard(
                                  _orderController.orders[index], index);
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
