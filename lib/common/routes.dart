import 'package:get/route_manager.dart';
import 'package:chat_app/views/cart_page.dart';
import 'package:chat_app/views/first_page.dart';
import 'package:chat_app/views/home_page.dart';

class RouteClass {
  static String home = '/';
  static String firstPage = '/firstPage';
  static String cartPage = '/cartPage';

  static String getHome() => home;
  static String getFirst() => firstPage;
  static String getCart() => cartPage;

  static List<GetPage> routes = [
    GetPage(page: () => HomePage(), name: home),
    GetPage(page: () => FirstPage(), name: firstPage),
    GetPage(page: () => CartPage(), name: cartPage),
  ];
}
