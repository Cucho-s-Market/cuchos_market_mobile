import 'package:cuchos_market_mobile/pages/register_page.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:cuchos_market_mobile/widgets/logo.dart';
import 'package:cuchos_market_mobile/widgets/reset_password.dart';
import 'package:cuchos_market_mobile/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  void recoverPasswordModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const ResetPassword(),
      ),
    );
  }

  void login() {
    debugPrint(_emailController.text);
    debugPrint(_passwordController.text);

    SessionController()
        .login(
      _emailController.text,
      _passwordController.text,
    )
        .then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
      onError: (error) {
        setState(() {
          errorMessage = error.toString();
        });
        debugPrint(error.toString());
      },
    );
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
            const Logo(height: 100),
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
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              icon: Icons.password_rounded,
              errorMessage: errorMessage,
              label: 'Contraseña',
              isPassword: true,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: login,
                child: const Text("Login"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                ),
                child: const Text("Registrarse"),
              ),
            ),
            TextButton(
              onPressed: recoverPasswordModal,
              child: const Text('Recuperar contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
