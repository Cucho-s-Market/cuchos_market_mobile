import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _doorNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  String? errorMessage;

  void showLoadingAnimation() {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void addAddress() {
    showLoadingAnimation();

    SessionController()
        .addAddress(
          Address(
            address: _addressController.text,
            doorNumber: int.tryParse(_doorNumberController.text),
            location: _locationController.text,
            state: _stateController.text,
          ),
        )
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Dirección creada'),
              content: const Text('Dirección creada correctamente.'),
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
              title: const Text('Error al crear dirección'),
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
              'Agregar dirección',
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
                onPressed: addAddress,
                child: const Text(
                  "Crear dirección",
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
