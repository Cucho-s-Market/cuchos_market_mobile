import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  final Widget title;
  final Widget child;

  const Section({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
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
              TextButton(
                onPressed: () {},
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
