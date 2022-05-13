import 'package:flutter/material.dart';
import 'package:flutterfood/controllers/cart_controller.dart';
import 'package:flutterfood/pages/food/popular_food_detail.dart';
import 'package:flutterfood/pages/home/home_food_page.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:flutterfood/utils/dimensions.dart';
import 'package:flutterfood/widgets/app_icon.dart';
import 'package:flutterfood/widgets/big_text.dart';
import 'package:flutterfood/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

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
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios, iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,),
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.home_outlined, iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,),
                  ),
                  AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,),
                ],
          )),
          Positioned(
            top: Dimensions.height20*5,
            bottom: 0,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Container(
              //color: Colors.red,
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  return ListView.builder(
                  itemCount: cartController.getItems.length,
                  itemBuilder: (_,index){
                    return Container(
                      height: Dimensions.height20*5, 
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Container(
                            height: Dimensions.height20*5,
                            width: Dimensions.width20*5,
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BAS_URL+cartController.getItems[index].img!)
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Expanded(
                            child: Container(
                              height: Dimensions.height20*5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                  SmallText(text: "Spicy"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: "\$ ${cartController.getItems[index].price}", color: Colors.redAccent,),
                                      Container(
                                        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.height10, bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                //popularProduct.setQuantity(false);
                                              },
                                              child: Icon(Icons.remove, color: AppColors.signColor,)),
                                            SizedBox(width: Dimensions.width10/2,),
                                            BigText(text: '0'), //'${popularProduct.inCartItems}'
                                            SizedBox(width: Dimensions.width10/2,),
                                            GestureDetector(
                                              onTap: () {
                                                //popularProduct.setQuantity(true);
                                              },
                                              child: Icon(Icons.add, color: AppColors.signColor,)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                            ),
                        ],
                      ),
                      );
                  });
                },),
              ),
            ),
            ),
        ],
      ),
    );
  }
}
