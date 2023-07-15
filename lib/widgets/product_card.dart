import 'package:cuchos_market_mobile/models/cart.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/image_loader.dart';
import 'package:cuchos_market_mobile/widgets/quantity_card.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final int initialQuantity;

  const ProductCard({Key? key, required this.product, required this.initialQuantity}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ValueNotifier<Map<Product, int>> cartContent = Cart().products;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void accept() {
    Cart().updateCart(product: widget.product, quantity: 0);
    Navigator.pop(context);
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: const Text('Desea eliminar el producto del carrito?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: accept,
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

  void _setQuantity(int newQuantity) {
    if (newQuantity == 0) {
      showAlertDialog(context);
    } else {
      //TODO: Agregar logica para maxima cantidad permitida
      quantity = newQuantity;
      Cart().updateCart(product: widget.product, quantity: quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(child: ImageLoader(imageUrl: widget.product.images.first)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.brand,
                    style: const TextStyle(color: Colors.white38),
                  ),
                  Text(
                    'U\$D ${widget.product.price.toString()}',
                    style: const TextStyle(color: Color.fromRGBO(245, 121, 59, 1), fontWeight: FontWeight.bold),
                  ),
                  QuantityCard(setQuantity: _setQuantity, currentQuantity: quantity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
