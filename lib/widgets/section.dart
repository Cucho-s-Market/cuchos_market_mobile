import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  final Widget title;
  final Widget child;
  final VoidCallback show;

  const Section({Key? key, required this.title, required this.child, required this.show}) : super(key: key);

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.title,
              if (buttonPressed)
                TextButton(
                  onPressed: () {
                    buttonPressed = false;
                    widget.show();
                  },
                  child: const Text("Ver menos"),
                )
              else
                TextButton(
                  onPressed: () {
                    buttonPressed = true;
                    widget.show();
                  },
                  child: const Text("Ver mas"),
                ),
            ],
          ),
          widget.child,
        ],
      ),
    );
  }
}
