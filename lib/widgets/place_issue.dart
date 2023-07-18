import 'package:cuchos_market_mobile/models/issue.dart';
import 'package:cuchos_market_mobile/models/order.dart';
import 'package:cuchos_market_mobile/utilities/order_controller.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';

class PlaceIssue extends StatefulWidget {
  final Order order;

  const PlaceIssue({Key? key, required this.order}) : super(key: key);

  @override
  State<PlaceIssue> createState() => _PlaceIssueState();
}

class _PlaceIssueState extends State<PlaceIssue> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? errorMessage;

  placeIssue() {
    OrderController()
        .placeIssue(
          Issue(
            title: _titleController.text,
            description: _descriptionController.text,
            userEmail: SessionController().user!.email,
            creationDate: DateTime.now(),
            order: widget.order,
          ),
        )
        .then(
          (value) => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Reclamo enviado'),
              content: Text('El reclamo sobre la orden ${widget.order.id} fue enviado con éxito.'),
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
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Error al enviar reclamo'),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Realizar reclamo sobre orden #${widget.order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      label: const Text("Título"),
                      errorText: errorMessage == null ? errorMessage : '',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.text_fields,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                      label: const Text("Descripción"),
                      errorText: errorMessage,
                      border: const OutlineInputBorder(),
                    ),
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
                onPressed: placeIssue,
                child: const Text(
                  "Enviar",
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
