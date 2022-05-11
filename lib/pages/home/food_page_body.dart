import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutterfood/controllers/popular_product_controller.dart';
import 'package:flutterfood/models/products_model.dart';
import 'package:flutterfood/pages/food/popular_food_detail.dart';
import 'package:flutterfood/routes/route_helper.dart';
import 'package:flutterfood/utils/app_constants.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:flutterfood/utils/dimensions.dart';
import 'package:flutterfood/widgets/app_column.dart';
import 'package:flutterfood/widgets/big_text.dart';
import 'package:flutterfood/widgets/icon_and_text_widget.dart';
import 'package:flutterfood/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({ Key? key }) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scalefactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() { 
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts){
            return popularProducts.isLoaded? Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),
                ) : CircularProgressIndicator(color: AppColors.mainColor);
          }
          ),
        GetBuilder<PopularProductController>(
          builder: (popularProducts){
            return DotsIndicator(
          dotsCount: popularProducts.popularProductList.length<=0? 1 : popularProducts.popularProductList.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: Size.square(9),
            activeSize: Size(18,9),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius20)),
            activeColor: AppColors.mainColor,
          ),
          );
          }
          ),
          SizedBox(height: Dimensions.height30,),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(text: ":", color: Colors.black26,),
                ),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing",),
                ),
              ],
            ),
          ),
          GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts){
              return  recommendedProducts.isLoaded? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProducts.recommendedProductList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getRecommendedFood(index));
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      Container(
                        height: Dimensions.listViewImgSize,
                        width: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(AppConstants.BAS_URL+recommendedProducts.recommendedProductList[index].img!)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                          color: Colors.white
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProducts.recommendedProductList[index].name!),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: "with chinese characteristics"),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp, 
                                      iconColor: AppColors.iconColor1, 
                                      text: "Normal",
                                      ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      iconColor: AppColors.mainColor, 
                                      text: "1.7Km",
                                      ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded, 
                                      iconColor: AppColors.iconColor2, 
                                      text: "32min",
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            ) : CircularProgressIndicator(color: AppColors.mainColor);
            } 
            ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scalefactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index==_currPageValue.floor()+1){
      var currScale = _scalefactor+(_currPageValue-index+1)*(1-_scalefactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scalefactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scalefactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              height: Dimensions.pageViewContainer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30), 
                color:index.isEven ? Color(0xFF69c5df): Color(0xFF9294cc),
                image: DecorationImage(image: NetworkImage(AppConstants.BAS_URL +  popularProduct.img!),
                fit: BoxFit.cover)
                ),
              
              ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              height: Dimensions.pageViewTextContainer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20), 
                color:Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE8E8E8),
                    blurRadius: 5,
                    offset: Offset(0,5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0),
                  )
                ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                  child: AppColumn(text: popularProduct.name!,),
                ),
              ),
            ),
    
        ],
      ),
    );
  }
}