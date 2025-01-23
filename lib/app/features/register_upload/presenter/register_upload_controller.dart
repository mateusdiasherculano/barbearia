import 'package:barbearia/app/features/register_upload/presenter/register_upload_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUploadController extends Disposable {
  final RegisterUploadStore registerUploadStore;

  final ValueNotifier<String?> imagePath = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  RegisterUploadController(this.registerUploadStore);

  Future<void> takeCameraPhoto() async {
    isLoading.value = true;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 1024, maxWidth: 1024);

    if (image?.path != null) {
      imagePath.value = image?.path;
    }
    isLoading.value = false;
  }

  Future<void> takeGalleryPhoto() async {
    isLoading.value = true;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 1024, maxWidth: 1024);

    if (image?.path != null) {
      imagePath.value = image?.path;
    }
    isLoading.value = false;
  }

  Future<void> updateController() async {
    await registerUploadStore.saveImage(imagePath.value!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
