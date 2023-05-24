import 'package:cuchos_market_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(245, 121, 59, 1),
          error: Color.fromRGBO(240, 58, 71, 1),
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'OpenSans',
        dividerColor: Colors.transparent,
      ),
      home: const CuchosMarketPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CuchosMarketPage extends StatefulWidget {
  const CuchosMarketPage({super.key});
  @override
  State<CuchosMarketPage> createState() => _CuchosMarketPageState();
}

class _CuchosMarketPageState extends State<CuchosMarketPage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
