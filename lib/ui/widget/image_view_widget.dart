import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';

/// Verilen pathdeki yolu bulup oradaki resmi gösterir.
class ImageViewWidget extends StatelessWidget {
  ImageViewWidget({super.key, required this.imagePath});

  final String imagePath;
  bool _isInternetToPhoto = false;

  @override
  Widget build(BuildContext context) {
    _isInternetToPhoto = imagePath.startsWith('https:');
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Resim Detayı',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'product_image',
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _isInternetToPhoto
                    ? Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(imagePath),
                      )
                    : Image(
                        fit: BoxFit.contain,
                        image: FileImage(File(imagePath)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
