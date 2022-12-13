import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products_model.dart';
import '../services/api_hundler.dart';
import '../widgets/feeds_widget.dart';

// Block (SCREEN) All Products
class FeedsScreen extends StatefulWidget {
  const FeedsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductsModel> productsList = [];

  /* ------------------------------------------------------------- */
  // Получаем данные с файла (api_handler.dart)
  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts();
    setState(() {});
  }
  // Изменил зависимость
  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }
  /* ------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 8,
              ),
            )
          : GridView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: const FeedsWidget(),
                );
              },
            ),
    );
  }
}
