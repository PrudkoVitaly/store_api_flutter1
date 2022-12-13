import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter/constants/global_colors.dart';
import 'package:store_api_flutter/services/api_hundler.dart';
import 'package:store_api_flutter/widgets/appbar_icons.dart';

import '../models/products_model.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductsModel? productsModel;

  Future<void> getProductInfo() async {
    productsModel = await APIHandler.getProductById(id: widget.id);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Detail"),
      ),
      body: SafeArea(
          child: productsModel == null
              ?  const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        productsModel!.category!.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              productsModel!.title.toString(),
                              style: titleStyle,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: RichText(
                              text: TextSpan(
                                text: "\$",
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: Color.fromRGBO(33, 150, 243, 1),
                                ),
                                children: [
                                  TextSpan(
                                    text: productsModel!.price?.toString(),
                                    style: TextStyle(color: lightTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Block Slider
                      SizedBox(
                        height: size.height * 0.4,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FancyShimmerImage(
                              imageUrl: productsModel!.images![index].toString(),
                              boxFit: BoxFit.fill,
                              width: double.infinity,
                            );
                          },
                          autoplay: true,
                          itemCount: 3,
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.black12,
                              activeColor: Colors.red,
                              space: 10,
                            ),
                          ),
                        ),
                      ),

                      // Block Description
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(fontSize: 25),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productsModel!.description.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }
}
