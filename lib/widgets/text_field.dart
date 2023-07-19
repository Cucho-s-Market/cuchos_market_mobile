import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool isPassword;
  final IconData icon;
  final String? errorMessage;

  const TextFieldInput(
      {Key? key, required this.textEditingController, required this.label, required this.isPassword, required this.icon, required this.errorMessage})
      : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          label: Text(widget.label),
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey[400],
          ),
          errorText: widget.errorMessage,
        ),
      ),
    );
  }
}
