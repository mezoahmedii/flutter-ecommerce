import 'package:ecommerce/core/widgets/customButton.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  final List products;

  const ProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) => ListView.builder(
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.network(
                      products[i].image!,
                      width: 100,
                      errorBuilder: (context, object, stackTrace) {
                        return Container(
                          height: 200,
                          color: Color(0xFFe06e8f),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(products[i].name!,
                              style: const TextStyle(fontSize: 20)),
                          (products[i].discount != 0)
                              ? Row(
                                  children: [
                                    Text("\$${products[i].oldPrice!}  ",
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.black54)),
                                    Text("\$${products[i].price!}")
                                  ],
                                )
                              : Text("\$${products[i].price!}"),
                          (state is HomeLoading)
                              ? const CircularProgressIndicator()
                              : Row(
                                  children: [
                                    CustomButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/productInfoScreen",
                                              arguments: products[i].id);
                                        },
                                        text: "More Info"),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CustomButton(
                                        onPressed: () {
                                          HomeCubit.get(context).addFavorite(
                                              context, products[i].id!);
                                        },
                                        text: (products[i].inFavorites! == true)
                                            ? "Unfavorite"
                                            : "Favorite"),
                                  ],
                                ),
                          (state is HomeLoading)
                              ? Container()
                              : CustomButton(
                                  onPressed: () {
                                    HomeCubit.get(context)
                                        .addToCart(context, products[i].id!);
                                  },
                                  text: (products[i].inCart! == true)
                                      ? "Remove from cart"
                                      : "Add to cart"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}
