import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerScreen extends StatelessWidget {
  final String modelPath;

  const ModelViewerScreen({Key? key, required this.modelPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModelViewer(
        src: modelPath,
        alt: '3D Model',
        autoPlay: true,
        cameraControls: true,
        ar: true,
        poster: 'asset/images/logo.png',
      ),
    );
  }
}
