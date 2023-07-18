import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  String? errorMessage;

  void resetPassword() {
    SessionController()
        .resetPassword(_emailController.text)
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Solicitud enviada'),
              content: const Text('Verifique su casilla de correo.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ),
        )
        .onError(
          (error, stackTrace) => setState(
            () {
              errorMessage = error.toString();
            },
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
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                'Recuperar contraseña',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text('Ingrese el email asociado a su cuenta'),
            ),
            TextFieldInput(
              textEditingController: _emailController,
              icon: Icons.alternate_email,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Email',
              isPassword: false,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: resetPassword,
                child: const Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
