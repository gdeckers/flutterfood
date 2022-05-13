import 'package:flutter/material.dart';
import 'package:flutterfood/controllers/popular_product_controller.dart';
import 'package:flutterfood/pages/cart/cart_page.dart';
import 'package:flutterfood/pages/food/popular_food_detail.dart';
import 'package:flutterfood/pages/food/recommended_food_detail.dart';
import 'package:flutterfood/pages/home/home_food_page.dart';
import 'package:flutterfood/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CartPage(),  //MainFoodPage(), // RecommendedFood(), //
      //initialRoute: RouteHelper.initial,
      //getPages: RouteHelper.routes,
    );
  }
}
