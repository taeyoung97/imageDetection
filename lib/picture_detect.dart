import 'dart:io';
//package
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PictureDetect extends StatefulWidget {
  

  @override
  _PictureDetectState createState() => _PictureDetectState();
}

class _PictureDetectState extends State<PictureDetect> {
  ImagePicker _picker = ImagePicker();
  File _pickerImage;
  List<ImageLabel> _imageLabels = [];
  var result = "";



  //image_label_recognition
  processImageLabels(ImageSource source) async {
    PickedFile image = await _picker.getImage(source: source, maxHeight: 2000.0, maxWidth: 2000.0);
    _pickerImage = File(image.path);
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(_pickerImage);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    _imageLabels = await labeler.processImage(myImage);
    result = "";
    for (ImageLabel imageLabel in _imageLabels) {
      setState(() {
        result = result +
            imageLabel.text +
            ":" +
            imageLabel.confidence.toString() +
            "\n";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("객체 검출(Object Detection)"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _pickerImage == null
            ? Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text("사진을 넣어주세요")],))
            : Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.file(_pickerImage,width: 405,fit: BoxFit.fill)],))
            ),
            Divider(),
            SizedBox(height: 100,),
            Expanded(
              flex: 1,
              child: result == "" 
                ? Text("")
                : Text("$result"),),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: "btnGoToGallery",
                    icon: Icon(Icons.photo_library),
                    label: Text("갤러리 사진"),
                    onPressed: () {
                      processImageLabels(ImageSource.gallery);
                    },
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  FloatingActionButton.extended(
                    heroTag: "btnGoToCamera",
                    icon: Icon(Icons.camera),
                    label: Text("사진 촬영"),
                    onPressed: () {
                      processImageLabels(ImageSource.camera);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}