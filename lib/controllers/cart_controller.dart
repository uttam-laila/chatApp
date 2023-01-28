import 'dart:convert';
//import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/state_manager.dart';
import 'package:chat_app/models/product.dart';

class CartController extends GetxController {
  //var counter = 0.obs;
  final box = GetStorage();
  @override
  void onInit() {
    //box.erase();
    box.listen(() {
      print('box changed');
    });
    box.listenKey('totalPrice', (value) {
      print('new key is $value');
    });
    //box.remove('totalPrice');
    getProducts();
    totalPrice = double.parse(box.read('totalPrice') ?? '0');
    try {
      final String cartItems = box.read('inCart') ?? '[]';
      final List<Map<String, dynamic>> element =
          List<Map<String, dynamic>>.from(json.decode(cartItems) as List);
      for (final element in element) {
        inCart.add(Product.fromJson(element));
      }
    } catch (_) {
      print(_.toString());
    }

    super.onInit();
  }

  /*void increment() {
    counter++;
  }*/

  List<Product> products = <Product>[].obs;
  List<Product> inCart = <Product>[].obs;
  double totalPrice = 0;

  //static final _otherBox = () => GetStorage('inCart');

  void addOrRemove(Product product) {
    if (inCart.contains(product) == false) {
      inCart.add(product);
    } else {
      inCart.remove(product);
    }
    totalPrice =
        inCart.fold(0, (sum, element) => sum + element.price!.toDouble());
    box.write('totalPrice', '$totalPrice');
    try {
      final List inCartMapList = [];
      inCart.forEach((element) {
        inCartMapList.add(json.encode(element.toJson()));
      });
      box.write('inCart', '$inCartMapList');
    } catch (_) {
      print(_.toString());
    }
    update();
  }

  var dio = Dio();

  Future<void> getProducts() async {
    final response = await dio
        .get("https://fakestoreapi.com/products/category/women's%20clothing");
    if (response.statusCode == 200) {
      for (final element in response.data as List) {
        products.add(Product.fromJson(element as Map<String, dynamic>));
      }
    } else {
      throw 'Error';
    }
  }
}
