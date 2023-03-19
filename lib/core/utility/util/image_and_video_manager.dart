import 'package:image_picker/image_picker.dart';

class ImageAndVideoManager {
  late ImagePicker _imagePicker;

  ImageAndVideoManager() {
    _imagePicker = ImagePicker();
  }

  /// SOURCE olarak galeriye gider ve XFile formatında fotoğraf bilgilerini döndürür
  Future<XFile?> getPhotoFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    return xFile;
  }

  Future<XFile?> getPhotoFromCamera() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.camera);

    return xFile;
  }
}
