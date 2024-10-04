import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBanners extends StatelessWidget {
  final List banners;

  const HomeBanners({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 200,
          viewportFraction: 0.65,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 7),
          autoPlayAnimationDuration: const Duration(milliseconds: 500)),
      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: (i.image != null)
                  ? Image.network(
                      i.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, object, stackTrace) {
                        return Container(
                          height: 200,
                          color: Color(0xFFe06e8f),
                        );
                      },
                    )
                  : const Placeholder(),
            );
          },
        );
      }).toList(),
    );
  }
}
