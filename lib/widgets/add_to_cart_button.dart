import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({Key? key}) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonsState();
}

class _AddToCartButtonsState extends State<AddToCartButton> {
  bool isPressed = false;
  int quantity = 0;

  void showQuantityButton(bool state) {
    setState(() => isPressed = state);
  }

  void changeQuantity(bool operation) {
    setState(() {
      if (operation) {
        quantity += 1;
      } else if (quantity > 0) {
        quantity -= 1;
      }
    });
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
              onPressed: () => showQuantityButton(true),
              child: const Text("Agregar al Carrito"),
            ),
          )
        : Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => changeQuantity(false),
                      icon: const Icon(Icons.remove),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => changeQuantity(true),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () => showQuantityButton(false),
                  child: const Text("Confirmar"),
                ),
              )
            ],
          );
  }
}
