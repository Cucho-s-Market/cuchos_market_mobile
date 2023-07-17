import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:cuchos_market_mobile/widgets/logo.dart';
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
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: const Text("Email"),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.grey[400],
                ),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: const Text("Password"),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.password_rounded,
                  color: Colors.grey[400],
                ),
                errorText: errorMessage,
              ),
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
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {},
                child: const Text("Registrare"),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Recuperar contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
