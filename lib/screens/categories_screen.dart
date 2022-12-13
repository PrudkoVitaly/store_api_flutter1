import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter/models/categories_model.dart';

import '../services/api_hundler.dart';
import '../widgets/category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<CategoriesModel>>(
        future: APIHandler.getAllCategories(),
        builder: (context, jsonData) {
          if (jsonData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Colors.green, strokeWidth: 8),
            );
          } else if (jsonData.hasError) {
            Center(
              child: Text("An error occurred ${jsonData.error}"),
            );
          } else if (jsonData.data == null) {
            const Text("No products has been added yet}");
          }
          return GridView.builder(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: jsonData.data![index],
                child: CategoryWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
