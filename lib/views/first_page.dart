import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:chat_app/common/routes.dart';
import 'package:chat_app/controllers/cart_controller.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Shop it"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GetX<CartController>(builder: (_controller) {
              return ListView.builder(
                itemCount: controller.products.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 207, 140),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Image.network(
                              controller.products[index].image?.toString() ??
                                  '0',
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Text(
                                controller.products[index].title ?? 'No Name',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            subtitle: Text(
                              '\$' +
                                  (controller.products[index].price
                                          ?.toString() ??
                                      '0'),
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _controller
                                    .addOrRemove(controller.products[index]);
                              },
                              icon: GetBuilder<CartController>(
                                  builder: (_controller) {
                                return Icon(_controller.inCart
                                        .contains(controller.products[index])
                                    ? Icons.remove
                                    : Icons.add);
                              }),
                            ),
                          ),
                          RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: Colors.orangeAccent)]),
            child: GetBuilder<CartController>(builder: (_controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Total Price: ${_controller.totalPrice.toStringAsFixed(2)}'),
                  Text('Total Items: ${_controller.inCart.length}'),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteClass.getCart()),
        tooltip: '',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}
