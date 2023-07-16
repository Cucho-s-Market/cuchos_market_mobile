import 'package:cuchos_market_mobile/models/item.dart';
import 'package:cuchos_market_mobile/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;

  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => Card(
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: 130,
                child: ImageLoader(imageUrl: items.elementAt(index).product?.images.first),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' ${items.elementAt(index).product!.name} (X${items.elementAt(index).quantity})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      items.elementAt(index).product!.brand,
                      style: const TextStyle(color: Colors.white38),
                    ),
                    Text(
                      'U\$D ${items.elementAt(index).product!.price.toString()} C/U',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
