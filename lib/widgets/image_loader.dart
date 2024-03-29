import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageLoader extends StatelessWidget {
  final String? imageUrl;

  const ImageLoader({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Opacity(
        opacity: 0.7,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
          image: imageUrl ?? '',
          imageErrorBuilder: (context, error, stackTrace) => const Center(
            child: Text(
              'NO DATA',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
