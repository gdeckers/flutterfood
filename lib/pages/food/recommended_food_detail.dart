import 'package:flutter/material.dart';
import 'package:flutterfood/controllers/recommended_product_controller.dart';
import 'package:flutterfood/routes/route_helper.dart';
import 'package:flutterfood/utils/app_constants.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:flutterfood/utils/dimensions.dart';
import 'package:flutterfood/widgets/app_icon.dart';
import 'package:flutterfood/widgets/big_text.dart';
import 'package:flutterfood/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFood extends StatelessWidget {
  final int pageId;
  const RecommendedFood({ Key? key, required this.pageId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height30*2.3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            expandedHeight: 300,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10/2, bottom: Dimensions.height10),
                width: double.maxFinite,
                child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BAS_URL+product.img!,
              width: double.maxFinite,
              fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10/2),
                  child: ExpandableTextWidget(text: product.description!)
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(Dimensions.width20*2.5, Dimensions.height10, Dimensions.width20*2.5, Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.remove, backgroundColor: AppColors.mainColor, iconColor: Colors.white, size: Dimensions.iconSize34,),
                BigText(text: "\$ ${product.price!} X 0 ", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                AppIcon(icon: Icons.add, backgroundColor: AppColors.mainColor, iconColor: Colors.white, size: Dimensions.iconSize34,)
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                  ),
                  child: Icon(Icons.favorite, color: AppColors.mainColor,),
                ),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20, bottom: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}