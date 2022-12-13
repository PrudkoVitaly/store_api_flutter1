import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../services/api_hundler.dart';
import 'feeds_widget.dart';

// Main Screen Block All Products
class FeedsGridWidget extends StatefulWidget {
  final List<ProductsModel> productsList;


  const FeedsGridWidget({
    Key? key,
    required this.productsList,
  }) : super(key: key);

  @override
  State<FeedsGridWidget> createState() => _FeedsGridWidgetState();
}

class _FeedsGridWidgetState extends State<FeedsGridWidget> {

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
    return Expanded(
      child: GridView.builder(
        itemCount: productsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: widget.productsList[index],
            child: const FeedsWidget(),
          );
        },
      ),
    );
  }
}
