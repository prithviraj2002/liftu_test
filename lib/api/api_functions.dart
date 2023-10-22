import 'dart:convert';

import 'package:lift_u_test/constants/strings.dart';
import 'package:lift_u_test/model/category_model.dart';
import 'package:lift_u_test/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiFunctions{

  static Future<List<Product>> getProducts({int categoryId = 0}) async{

    List<Product> products = [];

    try{
      final response = await http.get(Uri.parse(AppStrings.url+categoryId.toString()));
      final data = jsonDecode(response.body);
      for(Map<String, dynamic> p in data){
        products.add(Product.fromJson(p));
      }
      return products;
    } on Exception catch(e){
      print(e);
      rethrow;
    }
  }

  static Future<List<Category>> getCategories() async{

    List<Category> categories = [];

    try{
      final response = await http.get(Uri.parse(AppStrings.categoriesUrl));
      final data = jsonDecode(response.body);
      for(Map<String, dynamic> c in data){
        categories.add(Category.fromJson(c));
      }
      return categories;
    }on Exception catch(e){
      print(e);
      rethrow;
    }
  }

}