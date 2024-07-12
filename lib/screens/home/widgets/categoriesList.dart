import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List categories;

  const CategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/productsScreen",
                arguments: categories[i].id!);
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(categories[i].image),
                radius: 40,
              ),
              Text(
                categories[i].name!,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      shrinkWrap: true,
    );
  }
}
