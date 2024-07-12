import 'package:flutter/material.dart';

class FavoritesGrid extends StatelessWidget {
  final List favorites;
  const FavoritesGrid({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: favorites.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {Navigator.pushNamed(context, "/productInfoScreen", arguments: favorites[i].id!);},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Image.network(favorites[i].image!, height: 120, width: 150),
                  Expanded(child: Text(favorites[i].name!))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
