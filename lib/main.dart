import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:chat_app/controllers/auth_controller.dart';

import 'common/routes.dart';
import 'controllers/cart_controller.dart';
import 'firebase_options.dart'; 

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<CartController>(() => CartController());
  Get.lazyPut<AuthController>(() => AuthController());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'flutter2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FirstPage(),
      initialRoute: RouteClass.home,
      getPages: RouteClass.routes,
    );
  }
}
