import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'categories_model.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;

  ProductsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoriesModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }

  // Метод который принимает (List productsJson) саисок продуктов, перебирает и возвращает его
  static List<ProductsModel> productsFromJson(List productsJson) {
    // print(productsJson[0]);
    return productsJson.map((data) {
      return ProductsModel.fromJson(data);
    }).toList();
  }
}

