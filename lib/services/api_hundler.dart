import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter/constants/api_consts.dart';
import 'package:store_api_flutter/models/categories_model.dart';
import 'package:store_api_flutter/models/products_model.dart';

import '../models/users_modal.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    var uri = Uri.http(BASE_URL, "/api/v1/$target");
    var response = await http.get(uri);

    // Получаем обьекты Json
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("V $v \n\n");
    }
    // Возвращаем весь список продуктов
    return tempList;
  }

  // Products
  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getData(target: "products");
    // Возвращаем весь список продуктов
    return ProductsModel.productsFromJson(temp);
  }

  // Products Detail
  static Future<List<ProductsModel>> getProductDetail() async {
    List temp = await getData(target: "users");
    // Возвращаем весь список каьегорий
    return ProductsModel.productsFromJson(temp);
  }

  // Categories
  static Future<List<CategoriesModel>> getAllCategories() async {
    List temp = await getData(target: "categories");
    // Возвращаем весь список каьегорий
    return CategoriesModel.categoriesFromJson(temp);
  }

  // Users
  static Future<List<UsersModal>> getAllUsers() async {
    List temp = await getData(target: "users");
    // Возвращаем весь список каьегорий
    return UsersModal.usersFromJson(temp);
  }

 // Product Detail
  static Future<ProductsModel> getProductById({required String id}) async {
    var uri = Uri.http(BASE_URL, "/api/v1/products/$id");
    var response = await http.get(uri);

    // Получаем обьекты Json
    var data = jsonDecode(response.body);
    return ProductsModel.fromJson(data);
  }
}
