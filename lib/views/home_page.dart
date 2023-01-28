import 'package:flutter/material.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:chat_app/common/routes.dart';
import 'package:chat_app/controllers/cart_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            
          },
            child: Image.network(
                'https://onymos.com/wp-content/uploads/2020/10/google-signin-button-1024x260.png')),
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
