import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesModel with ChangeNotifier{
  int? id;
  String? name;
  String? image;

  CategoriesModel({this.id, this.name, this.image});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

// Метод который принимает (List categoriesJson) саисок категорий, перебирает и возвращает его
  // Метод который принимает (List productsJson) саисок продуктов, перебирает и возвращает его
  static List<CategoriesModel> categoriesFromJson(List categoriesJson) {
    // print(categoriesJson[0]);
    return categoriesJson.map((data) {
      return CategoriesModel.fromJson(data);
    }).toList();
  }
}