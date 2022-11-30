import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store_api_flutter/widgets/appbar_icons.dart';

import '../constants/global_colors.dart';
import '../widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? _textEditingController;

  // Сохраняем данные в текстовом поле (TextFormField)
  @override
  void initState() {
    TextEditingController _textEditingController = TextEditingController();
    super.initState();
  }

  // При переходе на другую страницу удаляем данные
  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

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
                  function: () {},
                ),
              ),
            ],
          ),
          // Right icon side (actions)
          actions: [
            // Our widget
            AppBarIcons(
              function: () {},
              icon: IconlyBold.user3,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10, right: 10),
              child: TextFormField(
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
            // const SizedBox(height: 20,),
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
          ],
        ),
      ),
    );
  }
}
