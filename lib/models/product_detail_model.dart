import 'package:flutter/cupertino.dart';

class ProductDetail with ChangeNotifier{
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  ProductDetail(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
}

class Category with ChangeNotifier{
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

  // Метод который принимает (List productsDetailJson) саисок продуктов, перебирает и возвращает его
  static List<ProductDetail> productsFromJson(List productsDetailJson) {
    // print(productsJson[0]);
    return productsDetailJson.map((data) {
      return ProductDetail.fromJson(data);
    }).toList();
  }
}