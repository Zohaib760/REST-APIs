import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'display_picture.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    setState(() {}); // Trigger rebuild after assigning the future
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller,
            child: Center(child: Text("ZOHAIB", style: TextStyle(color: Colors.white),)),);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Stack(
        children:[ Positioned(
          bottom: 80,
         left: 150,
          child: FloatingActionButton(
            focusColor: Colors.transparent,

            backgroundColor: Colors.transparent,
            elevation: 0,
            
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                print('Image saved to: ${image.path}');
          
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(imagePath: image.path),
                  ),
                );
              } catch (e) {
                print('Error: $e');
              }
            },
            child: const Icon(Icons.camera,size: 100,),
          ),
        ),]
      ),
    );
  }
}
