import 'package:cuchos_market_mobile/models/order.dart';
import 'package:cuchos_market_mobile/models/order_status.dart';
import 'package:cuchos_market_mobile/utilities/order_controller.dart';
import 'package:cuchos_market_mobile/widgets/empty_orders.dart';
import 'package:cuchos_market_mobile/widgets/item_list.dart';
import 'package:cuchos_market_mobile/widgets/order_title.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
    initializeDateFormatting();
  }

  void loadOrders() {
    setState(
      () {
        isLoading = true;
        OrderController().loadOrders().then((value) => isLoading = false);
      },
    );
  }

  void cancelOrder(Order order) {
    OrderController().cancelOrder(order).then(
      (value) {
        loadOrders();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Orden cancelada'),
            content: const Text('Orden cancelada con éxito.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              )
            ],
          ),
        );
      },
    ).onError(
      (error, stackTrace) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Error al cancelar orden'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            )
          ],
        ),
      ),
    );
  }

  void cancelOrderDialog(Order order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar orden'),
        content: const Text('Desea cancelar esta orden?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cancelOrder(order);
            },
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      body: ValueListenableBuilder(
        valueListenable: OrderController().orders,
        builder: (context, orders, child) {
          if (isLoading) return const Center(child: CircularProgressIndicator());

          if (orders.isNotEmpty) {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: OrderTitle(
                      order: orders[index],
                    ),
                    children: [
                      if (orders.elementAt(index).items != null)
                        ItemList(
                          items: orders.elementAt(index).items!,
                        ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: orders.elementAt(index).status == OrderStatus.pending ? () => cancelOrderDialog(orders.elementAt(index)) : null,
                      child: const Text('Cancelar orden'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const EmptyOrders();
          }
        },
      ),
    );
  }
}
