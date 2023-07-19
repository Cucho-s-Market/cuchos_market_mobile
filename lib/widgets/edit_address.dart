import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAddress extends StatefulWidget {
  final Address address;
  const EditAddress({Key? key, required this.address}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  late TextEditingController _addressController;
  late TextEditingController _doorNumberController;
  late TextEditingController _locationController;
  late TextEditingController _stateController;
  String? errorMessage;

  @override
  void initState() {
    _addressController = TextEditingController(text: widget.address.address);
    _doorNumberController = TextEditingController(text: widget.address.doorNumber.toString());
    _locationController = TextEditingController(text: widget.address.location);
    _stateController = TextEditingController(text: widget.address.state);

    super.initState();
  }

  void showLoadingAnimation() {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void updateAddress() {
    showLoadingAnimation();

    SessionController()
        .updateAddress(
          Address(
            id: widget.address.id,
            address: _addressController.text,
            doorNumber: int.parse(_doorNumberController.text),
            location: _locationController.text,
            state: _stateController.text,
          ),
        )
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Dirección actualizada'),
              content: const Text('Dirección actualizada corrrectamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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
              title: const Text('Error al actualizar dirección'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Aceptar'),
                )
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar dirección',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    label: const Text("Dirección"),
                    errorText: errorMessage == null ? errorMessage : '',
                  ),
                ),
                TextFormField(
                  controller: _doorNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    label: const Text("Número de puerta"),
                    errorText: errorMessage == null ? errorMessage : '',
                  ),
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    label: const Text("Ciudad"),
                    errorText: errorMessage == null ? errorMessage : '',
                  ),
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    label: const Text("Estado"),
                    errorText: errorMessage == null ? errorMessage : '',
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.orange[900],
                ),
                onPressed: updateAddress,
                child: const Text(
                  "Actualizar dirección",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
