import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';

class AddressSelector extends StatefulWidget {
  final Function setAddress;
  final List<Address> addresses;

  const AddressSelector({Key? key, required this.setAddress, required this.addresses}) : super(key: key);

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.addresses.first.id!;
  }

  void selectAddress(int addressId) {
    setState(() => selectedItem = addressId);
    widget.setAddress(addressId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dirección de envio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            focusColor: Colors.transparent,
            icon: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(Icons.gps_fixed_rounded),
            ),
            value: selectedItem,
            items: SessionController()
                .addresses
                .value
                .map(
                  (address) => DropdownMenuItem(
                    value: address.id,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(address.address),
                    ),
                  ),
                )
                .toList(),
            onChanged: (address) => selectAddress(address!),
          ),
        ),
      ],
    );
  }
}
