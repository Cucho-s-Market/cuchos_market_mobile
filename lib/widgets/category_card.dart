import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatalogPage(
            products: category.products.values.toList(),
          ),
        ),
      ),
      child: Card(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Opacity(
              opacity: 0.7,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: category.image ?? '',
                imageErrorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'NO DATA',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
