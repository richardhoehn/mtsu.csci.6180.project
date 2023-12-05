import 'package:app/services/ticket.dart';
import 'package:app/widgets/take_picture_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureButton extends StatefulWidget {
  const TakePictureButton({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;

  @override
  State<TakePictureButton> createState() => _TakePictureButtonState();
}

class _TakePictureButtonState extends State<TakePictureButton> {

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    if (!mounted) return;
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePicturePage(camera: camera, ticket: widget.ticket),
        ));
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
