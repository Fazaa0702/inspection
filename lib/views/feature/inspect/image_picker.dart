import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:einspection/component/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerSection extends StatefulWidget {
  final void Function(String) onImageSelected;
  final TextEditingController? textEditingController;
  final String? initValue;
  const ImagePickerSection({
    super.key,
    required this.onImageSelected,
    this.textEditingController,
    this.initValue,
  });

  @override
  State<ImagePickerSection> createState() => _ImagePickerSectionState();
}

class _ImagePickerSectionState extends State<ImagePickerSection> {
  File? selectedImage;

  final picker = ImagePicker();

  String get hintText {
    if (selectedImage != null) {
      return selectedImage!.path.split('/').last;
    } else {
      return 'Tambahkan Gambar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width * 0.90,
          child: TextFormField(
            readOnly: true,
            controller: widget.textEditingController,
            onTap: () {
              showModalBottomSheet<void>(
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonFeatureButton(
                              buttonColor: const Color(0xFFFDF0CC),
                              onPressed: getImageFromCamera,
                              image: 'assets/images/formButton1.png',
                              text: 'Camera',
                              fontWeight: FontWeight.w600,
                            ),
                            CommonFeatureButton(
                              buttonColor: const Color(0xFFD4F4FE),
                              onPressed: getImageFromGallery,
                              image: 'assets/images/formButton2.png',
                              text: 'Gallery',
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
            cursorColor: const Color(0xFF47B347),
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF47B347)))),
          ),
        ),
        if (selectedImage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 300,
              child: Image.file(selectedImage!),
            ),
          ),
      ],
    );
  }

  Future getImageFromGallery() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    try {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
      print('Size: ${getFileSizeString(bytes: selectedImage!.lengthSync())}');
      String? base64String = imageToBase64(selectedImage);
      if (base64String != null) {
        widget.onImageSelected(base64String);
        print('Base64 Image: $base64String');
      } else {
        print('Failed to convert image to base64');
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }

    Get.back();
  }

  Future getImageFromCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 75);
      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
      print('Size: ${getFileSizeString(bytes: selectedImage!.lengthSync())}');
      String? base64String = imageToBase64(selectedImage);
      if (base64String != null) {
        widget.onImageSelected(base64String);
        print('Base64 Image: $base64String');
      } else {
        print('Failed to convert image to base64');
      }
    } catch (e) {
      print('Error picking image from gallery: $e');

      final LostDataResponse response = await picker.retrieveLostData();
      if (!response.isEmpty && response.file != null) {
        setState(() {
          selectedImage = File(response.file!.path);
        });
        print('resss: ${response.files}');
      }
    }

    Get.back();
  }

  String? imageToBase64(File? imageFile) {
    if (imageFile == null) return null;
    try {
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      print('Error converting image to base64: $e');
      return null;
    }
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
