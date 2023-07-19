import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/edit_address.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatefulWidget {
  final Address address;

  const AddressCard({Key? key, required this.address}) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  void showEditAddressModal({required Address address}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditAddress(address: address),
      ),
    );
  }

  void deleteAddress() {
    SessionController()
        .deleteAddress(widget.address)
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Dirección eliminada'),
              content: const Text('Dirección eliminada corrrectamente.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                )
              ],
            ),
          ),
        )
        .onError(
          (error, stackTrace) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error al eliminar dirección'),
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
            Row(
              children: [
                IconButton(
                  onPressed: () => showEditAddressModal(address: widget.address),
                  icon: const Icon(Icons.mode_edit_outline),
                ),
                IconButton(
                  onPressed: deleteAddress,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
