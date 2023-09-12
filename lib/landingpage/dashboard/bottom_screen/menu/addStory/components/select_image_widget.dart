// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/view/addproduct.dart';
import 'package:aagyo/services/core.dart';
import '../../../../../../styles/textstyle_const.dart';

class SelectImageWidget extends StatefulWidget {
  final Function(File)thumbnailCallback;
  final Function(File)videoImageCallback;
  const SelectImageWidget({
    super.key, required this.thumbnailCallback, required this.videoImageCallback,
  });

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageSelectionContainer(
          titleText: "Add Thumbnail",
          callBackFunction: widget.thumbnailCallback,

        ),
        ImageSelectionContainer(
          titleText: "Add Video Image",
          callBackFunction: widget.videoImageCallback,
        ),
      ],
    );
  }
}

class ImageSelectionContainer extends StatefulWidget {
  final String titleText;
  final Function(File) callBackFunction;
  const ImageSelectionContainer({
    super.key,
    required this.titleText, required this.callBackFunction,
  });

  @override
  State<ImageSelectionContainer> createState() =>
      _ImageSelectionContainerState();
}

class _ImageSelectionContainerState extends State<ImageSelectionContainer> {
  File? _selectedImage;
  imagePick({required ImageSource source}) async {
    File? image = await pickImage(source);

    if (image != null) {
      widget.callBackFunction(image);
      setState(() {
        _selectedImage = image;
      });
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText,
          style: AppTextStyles.kBody15SemiboldTextStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            Get.bottomSheet(
              Container(
                  height: 150,
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      TextButtons(
                        text: "Upload From Camera",
                        onPressed: ()  {
                          imagePick(source: ImageSource.camera);
                        },
                      ),
                      TextButtons(
                        text: "Upload From Gallery",
                        onPressed: () async {
                          imagePick(source: ImageSource.gallery);
                        },
                      ),
                    ],
                  )),
              isDismissible: true,
            );
          },
          child: Container(
            height: 150,
            width: 150,
            color: Colors.grey.shade400,
            child: _selectedImage == null
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add_a_photo_outlined),
                  )
                : Image.file(_selectedImage!, fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}
