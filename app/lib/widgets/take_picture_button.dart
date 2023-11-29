import 'dart:io';

import 'package:app/widgets/take_picture_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureButton extends StatefulWidget {
  const TakePictureButton({Key? key}) : super(key: key);

  @override
  State<TakePictureButton> createState() => _TakePictureButtonState();
}

class _TakePictureButtonState extends State<TakePictureButton> {
  XFile? image;

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    if (!mounted) return;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePicturePage(camera: camera),
        ));
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      onPressed: () {
        _showCamera();
      },
      child: const Text("Take Picture", style: TextStyle(color: Colors.white)),
    );
  }
}
