import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  String icon;
  void Function(String) onChange;

  ImageSelector(this.icon, this.onChange);

  Widget defaultIcon = Icon(
    IconData(57722, fontFamily: 'MaterialIcons'),
    size: 60,
  );
  Widget selectedImage = Icon(
    IconData(57722, fontFamily: 'MaterialIcons'),
    size: 60,
  );

  @override
  Widget build(BuildContext context) {
    print("building for ${icon}");
    return Container(
      width: 200,
      alignment: Alignment.topCenter,
      height: 200,
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: _onImageButtonPressed,
        child: CircleAvatar(
          radius: 80,
          child: selectedImage,
        ),
      ),
    );
  }

  void _onImageButtonPressed() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowedExtensions: ["jpg"]);

      if (result != null) {
        String? path = result.files.single.path;
        if (path != null) {
          File f = File(path);
          selectedImage = Image.file(f);
          return;
        }
      }
    } catch (e) {
      print(e);
    }
    selectedImage = defaultIcon;
  }
}
