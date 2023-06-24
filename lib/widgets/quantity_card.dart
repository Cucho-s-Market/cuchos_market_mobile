import 'package:flutter/material.dart';

class QuantityCard extends StatefulWidget {
  final Function setQuantity;
  final int currentQuantity;

  const QuantityCard({Key? key, required this.setQuantity, required this.currentQuantity}) : super(key: key);

  @override
  State<QuantityCard> createState() => _QuantityCardState();
}

class _QuantityCardState extends State<QuantityCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.currentQuantity;
  }

  void _changeQuantity(bool operation) {
    setState(
      () {
        if (operation) {
          quantity += 1;
        } else if (quantity > 0) {
          quantity -= 1;
        } else if (quantity == 0) {}
        widget.setQuantity(quantity);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.black87,
      child: Row(
        children: [
          IconButton(
            onPressed: () => _changeQuantity(false),
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
            onPressed: () => _changeQuantity(true),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
