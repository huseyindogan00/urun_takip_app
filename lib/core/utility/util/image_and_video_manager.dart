import 'package:image_picker/image_picker.dart';

class ImageAndVideoManager {
  late ImagePicker _imagePicker;

  ImageAndVideoManager() {
    _imagePicker = ImagePicker();
  }

  Future<XFile?> takePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.camera);

    return xFile;
  }

  Future<XFile?> getPhotoFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    return xFile;
  }
}
