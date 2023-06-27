import 'package:cuchos_market_mobile/models/address.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatefulWidget {
  final Address address;

  const AddressCard({Key? key, required this.address}) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.address.address,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${widget.address.location}, ${widget.address.state} ${widget.address.doorNumber}',
                  style: const TextStyle(color: Colors.white38),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mode_edit_outline),
            ),
          ],
        ),
      ),
    );
  }
}
