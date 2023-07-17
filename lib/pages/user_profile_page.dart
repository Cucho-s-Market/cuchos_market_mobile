import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/models/customer.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/widgets/add_address.dart';
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
  final TextEditingController _birthdateController = TextEditingController(text: SessionController().user?.birthdate.toString());
  final TextEditingController _telephoneController = TextEditingController(text: SessionController().user?.telephone.toString());
  final TextEditingController _dniController = TextEditingController(text: SessionController().user?.dni.toString());
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    await SessionController().loadAddresses();
  }

  void saveInformation() {
    SessionController()
        .updateUserInformation(
          Customer(
            email: _emailController.text,
            password: _passwordController.text,
            firstName: _firstnameController.text,
            lastName: _lastnameController.text,
            telephone: int.parse(_telephoneController.text),
            birthdate: DateTime.tryParse(_birthdateController.text),
            dni: int.parse(_dniController.text),
          ),
        )
        .then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Información actualizada'),
              content: const Text('Información actualizada corrrectamente.'),
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
            builder: (context) => AlertDialog(
              title: const Text('Error al actualizar información'),
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

  void showAddAddressModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddAddress(),
      ),
    );
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
              controller: _dniController,
              enabled: false,
              decoration: InputDecoration(
                label: const Text("Cédula"),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            TextFormField(
              controller: _emailController,
              enabled: false,
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
            TextFormField(
              controller: _telephoneController,
              decoration: InputDecoration(
                label: const Text("Teléfono"),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            TextFormField(
              controller: _birthdateController,
              enabled: false,
              decoration: InputDecoration(
                label: const Text("Fecha de nacimiento"),
                errorText: errorMessage == null ? errorMessage : '',
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: saveInformation,
                  child: const Text("Guardar"),
                ),
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
                    onPressed: showAddAddressModal,
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
          ],
        ),
      ),
    );
  }
}
