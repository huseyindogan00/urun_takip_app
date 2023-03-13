import 'dart:io';

import 'package:flutter/material.dart';

/// Verilen pathdeki yolu bulup oradaki resmi gösterir.
class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.backspace),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'product_image',
            child: Image(
              fit: BoxFit.cover,
              image: FileImage(File(imagePath)),
            ),
          ),
        ],
      ),
    );
  }
}
