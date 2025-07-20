// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffee_shop_app/controller/user_space/pages/basket_conroller.dart';
import 'package:coffee_shop_app/controller/user_space/pages/favorite_controller.dart';
import 'package:coffee_shop_app/controller/user_space/pages/home_page_controller.dart';
import 'package:coffee_shop_app/model/demande.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Beans_details_screen extends StatelessWidget {
  const Beans_details_screen({super.key});

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    final Home_page_controller _controller = Get.put(Home_page_controller());
    final Basket_controller _basketController = Get.put(Basket_controller());
    final Favorite_Controller _favoritcontroller =
        Get.put(Favorite_Controller());
    final Beans_details_controller _beansController =
        Get.put(Beans_details_controller());
    return Scaffold(
      body: Stack(
        children: [
          //img
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenHeight * 0.6,
                child: Image.asset(
                  _controller.selecteditem!.getImgUrl(),
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //charit li f nas
              Container(
                height: ScreenHeight * 0.2,
                color: Colors.black.withOpacity(0.4),
                child: Column(
                  children: [
                    //name,desc,bean,position
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                width: ScreenWidth * 0.5,
                                height: ScreenHeight * 0.057,
                                child: Text(_controller.selecteditem!.getName(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                width: ScreenWidth * 0.5,
                                height: ScreenHeight * 0.05,
                                child: Text(
                                    _controller.selecteditem!.getProperty(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 180, 180),
                                        fontFamily: 'Cairo',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: ScreenWidth * 0.06),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: SizedBox(
                                    height: ScreenWidth * 0.17,
                                    width: ScreenWidth * 0.17,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 27, 27, 27),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 3),
                                              child: Image.asset(
                                                  "images/icons/bean.png",
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66)),
                                            ),
                                          ),
                                          Text(
                                            "Beans",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                /*SizedBox(
                                  height: ScreenWidth * 0.1,
                                  width: ScreenWidth * 0.1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    child: Image.asset("images/icons/bean.png"),
                                  ),
                                )*/
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                                  child: SizedBox(
                                    height: ScreenWidth * 0.17,
                                    width: ScreenWidth * 0.17,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 27, 27, 27),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 3),
                                              child: Icon(Icons.place,
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66)),
                                            ),
                                          ),
                                          Text(
                                            "Position",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                /*SizedBox(
                                  height: ScreenWidth * 0.1,
                                  width: ScreenWidth * 0.1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    child: Image.asset("images/icons/bean.png"),
                                  ),
                                )*/
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    //stars,meduim
                    Row(
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 209, 121, 66),
                                    size: ScreenWidth * 0.08,
                                  ),
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    "(1089)",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenWidth * 0.30,
                                ),
                                Container(
                                    height: ScreenHeight * 0.06,
                                    width: ScreenWidth * 0.34 + 10,
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //description
              Container(
                height: ScreenHeight * 0.5 + 2,
                width: ScreenWidth,
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ListView(
                    children: [
                      //title description
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      //description
                      SizedBox(
                        height: ScreenHeight * 0.3,
                        child: Text(
                          "Cappuccino is a classic Italian coffee beverage known for its balanced flavor and rich texture. This drink is typically made with equal parts espresso, steamed milk, and milk foam. The espresso provides a strong, robust coffee base, while the steamed milk adds creaminess, and the milk foam on top adds a light, airy finish. Some variations include sprinkling cocoa powder or cinnamon on top for extra flavor. Cappuccino is often enjoyed as a morning coffee, offering a perfect blend of strength and smoothness to start the day.",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_beansController.quantity1.value ==
                                          0) {
                                        _beansController.quantity1.value = 1;
                                      } else {
                                        _beansController.quantity1.value = 0;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 27, 27, 27),
                                      fixedSize: Size(120, 80),
                                      shape: RoundedRectangleBorder(
                                          side: _beansController
                                                      .quantity1.value ==
                                                  1
                                              ? BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66))
                                              : BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 27, 27, 27)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Text(
                                      '250gm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_beansController.quantity2.value ==
                                          0) {
                                        _beansController.quantity2.value = 1;
                                      } else {
                                        _beansController.quantity2.value = 0;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 27, 27, 27),
                                      fixedSize: Size(120, 80),
                                      shape: RoundedRectangleBorder(
                                          side: _beansController
                                                      .quantity2.value ==
                                                  1
                                              ? BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66))
                                              : BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 27, 27, 27)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Text(
                                      '500gm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_beansController.quantity3.value ==
                                          0) {
                                        _beansController.quantity3.value = 1;
                                      } else {
                                        _beansController.quantity3.value = 0;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 27, 27, 27),
                                      fixedSize: Size(120, 80),
                                      shape: RoundedRectangleBorder(
                                          side: _beansController
                                                      .quantity3.value ==
                                                  1
                                              ? BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 209, 121, 66))
                                              : BorderSide(
                                                  width: 3,
                                                  color: Color.fromARGB(
                                                      255, 27, 27, 27)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Text(
                                      '1000gm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "Price",
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
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Icon(Icons.attach_money,
                                              color: Color.fromARGB(
                                                  255, 209, 121, 66)),
                                        ),
                                        Obx(
                                          () => Text(
                                              (_beansController
                                                              .quantity1.value *
                                                          _controller
                                                              .selecteditem!
                                                              .getPrice1() +
                                                      _beansController
                                                              .quantity2.value *
                                                          _controller
                                                              .selecteditem!
                                                              .getPrice2() +
                                                      _beansController
                                                              .quantity3.value *
                                                          _controller
                                                              .selecteditem!
                                                              .getPrice3())
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w900)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: ScreenWidth * 0.3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: SizedBox(
                                height: 60,
                                width: ScreenWidth * 0.55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (!_basketController.elementExist(
                                        _controller.selecteditem)) {
                                      _basketController.Basket.add(Demande(
                                          _controller.selecteditem,
                                          _beansController.quantity1.value,
                                          _beansController.quantity2.value,
                                          _beansController.quantity3.value,
                                          _basketController.Basket.length + 1,
                                          0));
                                      Get.snackbar(
                                        'Added to Cart',
                                        'The product has been added successfully!',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor:
                                            Colors.green.withOpacity(0.8),
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 2),
                                        animationDuration:
                                            Duration(milliseconds: 500),
                                        margin: EdgeInsets.all(16),
                                      );
                                    }
                                    _basketController.sumOfProducts();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 209, 121, 66),
                                    fixedSize: Size(120, 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
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
                    height: ScreenWidth * 0.1,
                    width: ScreenWidth * 0.1,
                    child: Icon(
                      color: Color.fromARGB(255, 180, 180, 180),
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (!_favoritcontroller.exist(_controller.selecteditem)) {
                      _favoritcontroller.favorit.add(_controller.selecteditem);
                    } else {
                      _favoritcontroller.favorit
                          .remove(_controller.selecteditem);
                      _favoritcontroller.update();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
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
                    height: ScreenWidth * 0.1,
                    width: ScreenWidth * 0.1,
                    child: GetBuilder<Favorite_Controller>(
                      builder: (controller) => Icon(
                        color:
                            _favoritcontroller.exist(_controller.selecteditem)
                                ? Colors.red
                                : Color.fromARGB(255, 100, 100, 100),
                        Icons.favorite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
style: TextStyle(
color: Colors.white,
 fontFamily: 'Cairo',
fontSize: 12,
fontWeight: FontWeight.w400),*/
