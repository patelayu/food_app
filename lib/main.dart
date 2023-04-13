
import 'package:flutter/material.dart';
import 'package:foodapp/screen/cartpage.dart';
import 'package:foodapp/screen/homepage.dart';
import 'package:foodapp/screen/splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(
    GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/HomePage',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/CartPage',
          page: () => const CartPage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}