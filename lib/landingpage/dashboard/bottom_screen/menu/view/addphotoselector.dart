// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:aagyo/const/constString.dart';

class PhotoSelectionWidget extends StatefulWidget {
  const PhotoSelectionWidget({super.key});

  @override
  _PhotoSelectionWidgetState createState() => _PhotoSelectionWidgetState();
}

class _PhotoSelectionWidgetState extends State<PhotoSelectionWidget> {
  final List<File> _selectedPhotos = [];

  Future<void> _selectPhoto() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedPhotos.add(File(pickedFile.path));
      });
    }
  }

  void _clearPhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_selectedPhotos.length < 5)
              InkWell(
                  onTap: () {
                    _selectPhoto();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(addproduct),
                  )),
            for (int i = _selectedPhotos.length - 1; i > 0; i--)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(_selectedPhotos[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 25,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xff554f51),
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 10,
                        ),
                        onPressed: () {
                          _clearPhoto(i);
                        },
                      ),
                    ),
                  ),
                ],
              ),

            // IconButton(
            //   icon: Icon(Icons.add_a_photo),
            //   onPressed: () {
            //     _selectPhoto();
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}
