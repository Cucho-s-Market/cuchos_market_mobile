import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/tool_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    //TODO: Agregar logica para realizar inicio de sesion
    debugPrint(_emailController.text);
    debugPrint(_passwordController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
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
            Flexible(
              fit: FlexFit.loose,
              child: SvgPicture.asset(
                fit: BoxFit.scaleDown,
                height: 100,
                'assets/images/logo.svg',
                semanticsLabel: 'Cucho\'s Market Logo',
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Divider(
                color: Colors.grey[600],
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                label: const Text("Email"),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: const Text("Password"),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.password_rounded,
                  color: Colors.grey[400],
                ),
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
          ],
        ),
      ),
    );
  }
}
