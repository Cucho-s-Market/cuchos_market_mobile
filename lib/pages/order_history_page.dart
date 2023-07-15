import 'package:cuchos_market_mobile/utilities/order_controller.dart';
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
  @override
  void initState() {
    super.initState();
    OrderController().loadOrders();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      body: ValueListenableBuilder(
        valueListenable: OrderController().orders,
        builder: (context, orders, child) => ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) => ExpansionTile(
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
        ),
      ),
    );
  }
}
