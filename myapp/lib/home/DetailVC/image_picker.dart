import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({super.key});

  @override
  State<ImagePickerDemo> createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  List<Widget> _imageFileList = [];

  final ImagePicker _picker = ImagePicker();
  double maxWidth = 140 * 2;
  double maxHeight = 90 * 2;
  int quality = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("image picker"),
          actions: [
            IconButton(
                onPressed: () {
                  pickImageAction();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Center(
          child: Column(
            children: _imageFileList,
          ),
        ));
  }

  ///获取相册
  void pickImageAction() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxHeight,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      if (pickedFile != null) {
        _cropImage222(pickedFile.path);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage222(String path) async {
    if (path.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
              title: '图片裁剪',
              doneButtonTitle: "完成",
              cancelButtonTitle: "取消",
              resetButtonHidden: true,
              aspectRatioPickerButtonHidden: true,
              rotateButtonsHidden: true,
              rectX: 0.0,
              rectY: 0.0,
              rectWidth: 140,
              rectHeight: 90),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        print("croppedFile");

        setState(() {
          Image image = Image.file(File(croppedFile.path));

          _imageFileList.add(image);
          _imageFileList.add(const SizedBox(
            height: 20,
          ));
        });
      }
    }
  }
}
