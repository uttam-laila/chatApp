import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:chat_app/common/routes.dart';
import 'package:chat_app/controllers/cart_controller.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (Timer t) {
      if (controller.currentIndex < 7) {
        controller.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        controller.pageController.animateToPage(0,
            duration: const Duration(seconds: 1), curve: Curves.ease);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            color: Colors.black54,
            height: 260,
            child: GetBuilder<AuthController>(builder: (_con) {
              return Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (value) {
                      // setState(() {
                      //   _con.setCurrentIndex(value);
                      // });
                    },
                    controller: _con.pageController,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                _con.currentIndex.value == index ? 8 : 16,
                            vertical:
                                _con.currentIndex.value == index ? 8 : 32),
                        child: AnimatedContainer(
                            height: 200,
                            color:
                                index.isEven ? Colors.amber : Colors.blueAccent,
                            duration: const Duration(seconds: 3)),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: _con.currentIndex.value == index
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                  onTap: () {
                    controller.loginWithGoogle();
                  },
                  child: Image.network(
                      'https://onymos.com/wp-content/uploads/2020/10/google-signin-button-1024x260.png')),
            ),
          ),
          FutureBuilder<List>(
            future: controller.getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              /* if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              } */

              Logger logger = Logger();

              if (snapshot.connectionState == ConnectionState.done) {
                logger.d(snapshot.data.last.toString());
                return SizedBox(
                  height: 120,width: 120,
                  child: Image.network(snapshot.data.last['photoUrl']),
                );
              }

              return const Text("loading");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteClass.getFirst()),
        tooltip: '',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}

class Triangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
