import 'package:flutter/material.dart';
import 'package:lift_u_test/api/api_functions.dart';
import 'package:lift_u_test/model/category_model.dart';
import 'package:lift_u_test/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier{

  Future<List<Product>> getAllProducts(int categoryId) async{
    List<Product> products = [];
    await ApiFunctions.getProducts().then((value){
      products = value;
    });
    return products;
  }

  Future<List<Category>> getAllCategories() async{
    List<Category> categories = [];
    await ApiFunctions.getCategories().then((value) => categories = value);
    return categories;
  }
}