import 'package:flutter/material.dart';
import 'package:flutterfood/controllers/cart_controller.dart';
import 'package:flutterfood/data/repository/popular_product_repo.dart';
import 'package:flutterfood/models/products_model.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else {
      print('deu ruim...');
    }
  }

  void setQuantity(bool isIncrement){
      if(isIncrement){
        _quantity = checkQuantity(_quantity+1);
      }else {
        _quantity = checkQuantity(_quantity-1);
      }
      update();
    }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Itens", "Deve ser maior do que zero",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return -quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Itens", "Limite máximo do pedido atingido",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white
      );
      return 20;
    }else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCArt(product);
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product ){
  //  if(_quantity>0){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print('id= ${value.id} and quantity= ${value.quantity}');
       });
  //  }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

}