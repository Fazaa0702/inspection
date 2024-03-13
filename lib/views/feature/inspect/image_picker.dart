import 'dart:convert';
import 'dart:io';

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
        TextFormField(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: const Color(0xFFFDF0CC)),
                                  onPressed: getImageFromCamera,
                                  child: SizedBox(
                                    width: 50,
                                    height: 100,
                                    child: Image.asset(
                                      'assets/images/formButton1.png',
                                      // height: 125,
                                    ),
                                  )),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Camera',
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: const Color(0xFFD4F4FE)),
                                  onPressed: getImageFromGallery,
                                  child: SizedBox(
                                    width: 50,
                                    height: 100,
                                    child: Image.asset(
                                      'assets/images/formButton2.png',
                                    ),
                                  )),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Gallery',
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
          cursorColor: const Color(0xFF47B347),
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF47B347)))),
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
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
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
          await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
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
}
