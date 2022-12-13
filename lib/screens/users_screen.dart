import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter/models/categories_model.dart';
import 'package:store_api_flutter/models/users_modal.dart';
import 'package:store_api_flutter/widgets/users_widget.dart';

import '../services/api_hundler.dart';
import '../widgets/category_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<UsersModal>>(
        future: APIHandler.getAllUsers(),
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
          return ListView.builder(
            itemCount: jsonData.data!.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: jsonData.data![index],
                child: const UsersWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
