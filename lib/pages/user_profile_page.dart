import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/address_card.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final ValueNotifier<List<Address>> addresses = SessionController().addresses;
  final TextEditingController _emailController = TextEditingController(text: SessionController().user?.email);
  final TextEditingController _passwordController = TextEditingController(text: SessionController().user?.password);
  final TextEditingController _firstnameController = TextEditingController(text: SessionController().user?.firstName);
  final TextEditingController _lastnameController = TextEditingController(text: SessionController().user?.lastName);
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    await SessionController().loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'Usuario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: const Text("Email"),
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
                errorText: errorMessage,
              ),
            ),
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(
                label: const Text("Nombre"),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                label: const Text("Apellido"),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Direcciones',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: addresses,
                builder: (context, value, child) => ListView.builder(
                  itemCount: addresses.value.length,
                  itemBuilder: (context, index) => AddressCard(
                    address: addresses.value.elementAt(index),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {},
                child: const Text("Guardar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
