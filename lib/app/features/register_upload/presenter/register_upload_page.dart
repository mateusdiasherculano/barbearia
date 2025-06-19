import 'dart:io';

import 'package:barbearia/app/features/register_upload/presenter/register_upload_controller.dart';
import 'package:barbearia/libraries/design_system/src/common/extension/widgets_extension.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/ErrorAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../libraries/design_system/src/widgets/button/button_loading.dart';
import '../../../../libraries/design_system/src/widgets/error/sucess_alert.dart';

class RegisterUploadPage extends StatefulWidget {
  const RegisterUploadPage({super.key});

  @override
  State<RegisterUploadPage> createState() => _RegisterUploadPageState();
}

class _RegisterUploadPageState extends State<RegisterUploadPage> {
  final RegisterUploadController controller = Modular.get();

  @override
  void initState() {
    controller.registerUploadStore.observer(onState: (state) {
      SuccessAlert(message: state.message).show(context);
      Modular.to.pushNamed('/BarberDashboard');
    }, onError: (error) {
      ErrorAlert(message: error?.message).show(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFf6f6f6),
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Upload your photo',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ValueListenableBuilder<String?>(
                    valueListenable: controller.imagePath,
                    builder: (context, imagePath, _) {
                      return CircleAvatar(
                        radius: 64,
                        backgroundImage: imagePath == null
                            ? const NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg')
                            : FileImage(File(imagePath)) as ImageProvider,
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 300),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text(
                                            'Camera',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal,
                                              height: 1.1764705882352942,
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            softWrap: false,
                                          ),
                                          onTap: () {
                                            controller.takeCameraPhoto();
                                            Navigator.of(context).pop();
                                          },
                                          leading: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color(0xFF000000),
                                            size: 40,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Galeria',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal,
                                              height: 1.1764705882352942,
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            softWrap: false,
                                          ),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            controller.isLoading.value = true;
                                            await controller.takeGalleryPhoto();
                                            controller.isLoading.value = false;
                                          },
                                          leading: const Icon(
                                            Icons.image_outlined,
                                            color: Color(0xFF000000),
                                            size: 40,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: ValueListenableBuilder<bool>(
                      valueListenable: controller.isLoading,
                      builder: (context, isLoading, child) {
                        return isLoading
                            ? const CircularProgressIndicator()
                            : Image.asset('assets/images/iconephoto.png');
                      },
                    ),
                  ),
                  const SizedBox(height: 200),
                  AnimatedBuilder(
                      animation: controller.registerUploadStore.selectLoading,
                      builder: (context, _) {
                        return Center(
                          heightFactor: 1,
                          child: Column(
                            children: [
                              ButtonLoading(
                                onPressed: () {
                                  controller.updateController();
                                },
                                text: 'Save image',
                                loading:
                                    controller.registerUploadStore.isLoading,
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
