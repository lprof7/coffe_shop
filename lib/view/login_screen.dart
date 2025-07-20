import 'package:coffee_shop_app/controller/login_controller.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_screen extends StatefulWidget {
  @override
  _Login_screenState createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen>
    with TickerProviderStateMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to build image card with enhanced 3D effects
  Widget _buildImageCard(String imagePath) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.orange.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(0.03)
                  ..rotateX(0.01),
                alignment: Alignment.center,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var obsecure = true.obs;
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    final LoginController _controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: ListView(
        children: [
          SizedBox(height: ScreenHeight * 0.1),
          // Display enhanced images with 3D effects
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.withOpacity(0.1),
                  Colors.transparent,
                  Colors.orange.withOpacity(0.05),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 30,
                  offset: Offset(0, 0),
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ImageSlideshow(
                width: ScreenWidth * 0.85,
                height: ScreenHeight * 0.27,
                initialPage: 0,
                indicatorColor: Colors.orange,
                indicatorBackgroundColor: Colors.grey.withOpacity(0.3),
                children: [
                  _buildImageCard('images/login/1.png'),
                  _buildImageCard('images/login/2.jpg'),
                  _buildImageCard('images/login/3.jpg'),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenHeight * 0.04),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Color.fromARGB(255, 180, 180, 180),
                  ),
                  controller: emailController,
                  validator: (val) =>
                      val == "" ? "Please enter an email" : null,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 180, 180, 180),
                      fontFamily: 'Cairo',
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 66, 66, 66),
                    prefixIcon: const Icon(
                      Icons.email,
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
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 66, 66, 66),
                      ),
                    ),
                    hintText: "Email...",
                  ),
                ),
                SizedBox(height: 30),
                Obx(() {
                  return TextFormField(
                    obscureText: obsecure.value,
                    controller: passwordController,
                    validator: (val) =>
                        val == "" ? "Please enter a password" : null,
                    decoration: InputDecoration(
                      suffixIcon: Obx(
                        () => GestureDetector(
                          onTap: () {
                            obsecure.value = !obsecure.value;
                          },
                          child: Icon(
                            obsecure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromARGB(255, 180, 180, 180),
                          ),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.vpn_key_rounded,
                        color: Color.fromARGB(255, 180, 180, 180),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 66, 66, 66),
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 66, 66, 66),
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                        fontFamily: 'Cairo',
                        fontSize: 14,
                      ),
                      hintText: "Password...",
                    ),
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 180, 180, 180),
                    ),
                  );
                }),
                SizedBox(height: 20),
                SizedBox(
                  height: ScreenWidth * 0.15,
                  width: ScreenWidth * 0.6,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder?>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      textStyle: MaterialStatePropertyAll<TextStyle?>(
                        TextStyle(fontFamily: 'Cairo', color: Colors.white),
                      ),
                      backgroundColor: MaterialStatePropertyAll<Color?>(
                        Color.fromARGB(255, 209, 121, 66),
                      ),
                    ),
                    onPressed: () {
                      _controller.login(
                        emailController.text,
                        passwordController.text,
                        context,
                      );
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Color.fromARGB(255, 180, 180, 180),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Registration functionality can be added here
                      },
                      child: Text(
                        "Create your account now",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
