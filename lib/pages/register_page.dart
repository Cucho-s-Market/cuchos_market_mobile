import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/logo.dart';
import 'package:cuchos_market_mobile/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  DateTime _birthdate = DateTime.now();

  String? errorMessage;

  void showLoadingAnimation() {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void register() {
    showLoadingAnimation();

    SessionController()
        .register(
      email: _emailController.text,
      password: _passwordController.text,
      firstName: _firstnameController.text,
      lastName: _lastnameController.text,
      telephone: _telephoneController.text,
      dni: _dniController.text,
      birthdate: _birthdate,
    )
        .then(
      (value) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Usuario creado'),
          content: const Text('Usuario creado corrrectamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
      onError: (error) {
        setState(() {
          Navigator.pop(context);
          errorMessage = error.toString();
        });
        debugPrint(error.toString());
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _birthdate) {
      setState(() {
        _birthdate = pickedDate;
        _birthdateController.text = DateFormat.yMMMd().format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(height: 50),
            Container(
              margin: const EdgeInsets.all(20),
              child: Divider(
                color: Colors.grey[600],
              ),
            ),
            TextFieldInput(
              textEditingController: _emailController,
              icon: Icons.alternate_email,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Email',
              isPassword: false,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              icon: Icons.password_rounded,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Contraseña',
              isPassword: true,
            ),
            TextFieldInput(
              textEditingController: _firstnameController,
              icon: Icons.text_fields,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Nombre',
              isPassword: false,
            ),
            TextFieldInput(
              textEditingController: _lastnameController,
              icon: Icons.text_fields,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Apellido',
              isPassword: false,
            ),
            TextFieldInput(
              textEditingController: _telephoneController,
              icon: Icons.phone,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Teléfono',
              isPassword: false,
            ),
            TextFieldInput(
              textEditingController: _dniController,
              icon: Icons.credit_card,
              errorMessage: errorMessage != null ? '' : errorMessage,
              label: 'Cédula',
              isPassword: false,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              behavior: HitTestBehavior.opaque,
              child: IgnorePointer(
                child: TextFieldInput(
                  textEditingController: _birthdateController,
                  icon: Icons.date_range,
                  errorMessage: errorMessage,
                  label: 'Fecha de nacimiento',
                  isPassword: false,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: register,
                child: const Text("Registrarse"),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
