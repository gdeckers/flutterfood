import 'package:flutter/material.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:flutterfood/utils/dimensions.dart';
import 'package:flutterfood/widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios, iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,),
                  AppIcon(icon: Icons.home_outlined, iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,),
                  AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,),
                ],
          )),
        ],
      ),
    );
  }
}
