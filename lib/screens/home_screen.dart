import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter/screens/categories_screen.dart';
import 'package:store_api_flutter/screens/feeds_screen.dart';
import 'package:store_api_flutter/screens/users_screen.dart';
import 'package:store_api_flutter/services/api_hundler.dart';
import 'package:store_api_flutter/widgets/appbar_icons.dart';
import 'package:store_api_flutter/widgets/users_widget.dart';

import '../constants/global_colors.dart';
import '../models/products_model.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  // Определяем переменную с возвращаемым списком ProductsModel
  // List<ProductsModel> productsList = [];

  // Сохраняем данные в текстовом поле (TextFormField)
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  /* ------------------------------------------------------------- */

  // При переходе на другую страницу удаляем данные
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  /* ------------------------------------------------------------- */

// Изменил зависимость
//   @override
//   void didChangeDependencies() {
//     getProducts();
//     super.didChangeDependencies();
//   }
//
//   // Получаем данные с файла (api_handler.dart)
//   Future<void> getProducts() async {
//     productsList = await APIHandler.getAllProducts();
//     setState(() {});
//   }

  /* ------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          // Left icon side (leading)
          leading: Row(
            children: [
              // Our widget
              Flexible(
                flex: 3,
                child: AppBarIcons(
                  icon: IconlyBold.category,
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const CategoriesScreen(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Right icon side (actions)
          actions: [
            // Our widget
            AppBarIcons(
              icon: IconlyBold.user3,
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const UsersScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),

        //  Block "TextEditingController" form search
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconsColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),

            //  Block Slider
            SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                itemCount: 3,
                autoplay: true,
                autoplayDelay: 2000,
                control: const SwiperControl(),
                viewportFraction: 0.8,
                scale: 0.9,
                itemBuilder: (ctx, index) {
                  return const SaleWidget();
                },
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,
                  ),
                ),
              ),
            ),

            //  Block "Latest Products",
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Latest Products",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  AppBarIcons(
                    function: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const FeedsScreen(),
                        ),
                      );
                    },
                    icon: IconlyBold.arrowRight2,
                  ),
                ],
              ),
            ),

            // Block List Widgets
            const SizedBox(height: 30),
            // Получаем данные всех продуктов
            FutureBuilder<List<ProductsModel>>(
              future: APIHandler.getAllProducts(),
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
                return FeedsGridWidget(productsList: jsonData.data!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
