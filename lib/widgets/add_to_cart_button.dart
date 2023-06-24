import 'package:cuchos_market_mobile/models/cart.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/quantity_card.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  final Product product;

  const AddToCartButton({Key? key, required this.product}) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonsState();
}

class _AddToCartButtonsState extends State<AddToCartButton> {
  bool isPressed = false;
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = cartContent.value[widget.product] ?? 1;
  }

  void _setQuantity(int newQuantity) => quantity = newQuantity;

  void _showQuantityButton(bool state) {
    if (!state) cartContent.value[widget.product] = quantity;

    setState(() => isPressed = state);
  }

  @override
  Widget build(BuildContext context) {
    return !isPressed
        ? Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => _showQuantityButton(true),
              child: const Text("Agregar al Carrito"),
            ),
          )
        : Column(
            children: [
              QuantityCard(
                setQuantity: _setQuantity,
                currentQuantity: quantity,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () => _showQuantityButton(false),
                  child: const Text("Confirmar"),
                ),
              )
            ],
          );
  }
}
