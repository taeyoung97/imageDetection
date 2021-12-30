import 'package:flutter/material.dart';
import 'dart:math' as math;
//package
import 'package:camera/camera.dart';
import 'package:imageweb/bndbox.dart';
import 'package:imageweb/camera.dart';
import 'package:imageweb/main.dart';
import 'package:tflite/tflite.dart';

const String ssd = "작동";
const String yolo = "Tiny YOLOv2";

class Objectrecognition extends StatefulWidget {
  final List<CameraDescription> cameras;

  Objectrecognition(this.cameras);

  @override
  _ObjectrecognitionState createState() => new _ObjectrecognitionState();
}

class _ObjectrecognitionState extends State<Objectrecognition> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;
    res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");

    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("객체 인식(Object Recognition)"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      ssd,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onSelect(ssd),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                ),
              ],
            ),
    );
  }
}