import 'dart:io';

import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;
  final Ticket ticket;

  const TakePicturePage({Key? key, required this.camera, required this.ticket}) : super(key: key);

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  late CameraController _cameraController;
  late Future _initializeCameraControllerFuture;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.max);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    Response resp = await dio.post('${Config.domain.scheme}://${Config.domain.host}/tickets/${widget.ticket.id}/images',
        data: formData);

    print("Picture Upload Resp: ${resp.statusCode}");

    return;
  }

  void _takePicture(BuildContext context) async {
    try {
      if (!_cameraController.value.isTakingPicture) {
        XFile image = await _cameraController.takePicture();
        if (!mounted) return;

        await uploadImage(File(image.path));

        Navigator.pop(context, image);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('Already taking a picture.')));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Image.asset(
          Config.images.squareWhiteLogo,
          fit: BoxFit.contain,
          height: 36,
        ),
        toolbarHeight: 55,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Config.colors.backgroundColor, width: 2),
                              borderRadius: const BorderRadius.all(Radius.circular(20))),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CameraPreview(_cameraController),
                            ),
                          )),
                    ),
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Config.colors.backgroundColor,
                    ),
                    onPressed: () => _takePicture(context),
                    child: const Text('Take Picture of Vehicle', style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
