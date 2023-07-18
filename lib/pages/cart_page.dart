import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/models/cart.dart';
import 'package:cuchos_market_mobile/models/item.dart';
import 'package:cuchos_market_mobile/models/order.dart';
import 'package:cuchos_market_mobile/models/order_type.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/utilities/branch_controller.dart';
import 'package:cuchos_market_mobile/utilities/order_controller.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/address_selector.dart';
import 'package:cuchos_market_mobile/widgets/empty_cart.dart';
import 'package:cuchos_market_mobile/widgets/product_card.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ValueNotifier<Map<Product, int>> cartContent = Cart().products;
  ValueNotifier<double> totalAmount = Cart().totalAmount;
  OrderType _orderType = OrderType.pick_up;
  Address? selectedAddress;

  void setAddress(int addressId) {
    selectedAddress = SessionController().addresses.value.firstWhere((address) => address.id == addressId);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await SessionController().loadAddresses();
  }

  void _showBuyModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Metodo de envio',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    RadioListTile(
                      value: OrderType.pick_up,
                      groupValue: _orderType,
                      title: const Text('Pick-Up'),
                      onChanged: (value) => setState(() => _orderType = value!),
                    ),
                    if (SessionController().addresses.value.isNotEmpty)
                      RadioListTile(
                        value: OrderType.delivery,
                        groupValue: _orderType,
                        title: const Text('Delivery'),
                        onChanged: (value) => setState(() => _orderType = value!),
                      ),
                  ],
                ),
                if (_orderType == OrderType.delivery)
                  AddressSelector(
                    setAddress: setAddress,
                    addresses: SessionController().addresses.value,
                  ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.orange[900],
                    ),
                    onPressed: _buyProducts,
                    child: const Text(
                      "Confirmar compra",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showOrderAcceptedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compra realizada'),
        content: const Text('La compra se realizó con éxito!'),
        actions: [
          TextButton(
            onPressed: () {
              Cart().cleanCart();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

  void showOrderErrorDialog(BuildContext context, {required String error}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error al realizar compra'),
        content: Text('Error al realizar compra: $error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

  void _buyProducts() async {
    List<Item> items = [];

    for (Product product in cartContent.value.keys) {
      items.add(
        Item(
          name: product.name,
          price: product.price,
          quantity: cartContent.value[product]!,
          product: product,
        ),
      );
    }

    Order order = Order(
      branchId: BranchController().selectedBranch.value.id!,
      creationDate: DateTime.now(),
      type: _orderType,
      items: items,
      addressId: selectedAddress?.id,
    );

    await OrderController()
        .placeOrder(order)
        .then((value) => showOrderAcceptedDialog(context))
        .onError((error, stackTrace) => showOrderErrorDialog(context, error: error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      body: ValueListenableBuilder(
        valueListenable: cartContent,
        builder: (context, products, child) {
          if (products.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => ProductCard(
                      product: products.keys.elementAt(index),
                      initialQuantity: products.values.elementAt(index),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: ValueListenableBuilder(
                        valueListenable: totalAmount,
                        builder: (context, amount, child) => Text(
                          'Total: \$$amount',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: _showBuyModal,
                        child: const Text("Comprar"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const EmptyCart();
          }
        },
      ),
    );
  }
}
