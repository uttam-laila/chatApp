import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/common/routes.dart';
import 'package:chat_app/controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: const Text(
          "Shop it",
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // list view of cart
          Expanded(
            child: GetX<CartController>(builder: (_controller) {
              return ListView.builder(
                itemCount: controller.inCart.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 207, 140),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Image.network(
                          controller.inCart[index].image?.toString() ?? '0',
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            controller.inCart[index].title ?? 'No Name',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            '\$' +
                                (controller.inCart[index].price?.toString() ??
                                    '0'),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _controller.addOrRemove(controller.inCart[index]);
                          },
                          icon: GetBuilder<CartController>(
                              builder: (_controller) {
                            return Icon(_controller.inCart
                                    .contains(controller.inCart[index])
                                ? Icons.remove
                                : Icons.add);
                          }),
                        ),
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
            ),
            child: GetBuilder<CartController>(builder: (_controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total Price: ${_controller.totalPrice}'),
                  Text('Total Items: ${_controller.inCart.length}'),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteClass.getFirst()),
        tooltip: '',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
//}
      
      
      
      
      
      
      
      
      
      
      
      /*Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GetX<CartController>(builder: (_controller) {
              return ListView.builder(
                itemCount: controller.inCart.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 230,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: const [BoxShadow(color: Colors.orange)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 80,
                            child: Image.network(
                                controller.products[index].image?.toString() ??
                                    '0'),
                          ),
                          Text(controller.products[index].title ?? 'No Name'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(controller.products[index].price
                                      ?.toString() ??
                                  '0'),
                              IconButton(
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
                              )
                            ],
                          )
                        ],
                      ));
                },
              );
            }),
          ),
          Container(
            height: 60,
            width: 160,
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: Colors.deepOrange)]),
            child: GetBuilder<CartController>(builder: (_controller) {
              return Column(
                children: [
                  Text('Total Price: ${_controller.totalPrice}'),
                  Text('Total Items: ${_controller.inCart.length}'),
                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteClass.getFirst()),
        tooltip: '',
        child: const Icon(Icons.arrow_back),
      ),
   
    
    );
  }
}
*/