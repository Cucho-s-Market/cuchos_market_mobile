import 'package:cuchos_market_mobile/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTitle extends StatelessWidget {
  final Order order;

  const OrderTitle({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fecha de orden',
              style: TextStyle(fontSize: 14, color: Colors.white38),
            ),
            Text(
              DateFormat('MMMM dd, yyyy', 'es').format(order.creationDate),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 14, color: Colors.white38),
            ),
            Text(
              order.totalPrice.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tipo de envio',
              style: TextStyle(fontSize: 14, color: Colors.white38),
            ),
            Text(
              order.clientAddress != null ? 'Delivery' : 'Retiro',
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estado',
              style: TextStyle(fontSize: 14, color: Colors.white38),
            ),
            Text(
              order.status!.status,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Text(
          'Orden #${order.id!}',
          style: const TextStyle(fontSize: 14, color: Colors.white38),
        ),
      ],
    );
  }
}
