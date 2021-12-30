import 'package:imageweb/object_recognition.dart';
//package
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imageweb/picture_detect.dart';

List<CameraDescription> cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExampleList(),
    );
  }
}

class ExampleList extends StatefulWidget {
  

  @override
  _ExampleListState createState() => _ExampleListState();
}

class _ExampleListState extends State<ExampleList> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("딥 러닝")
      ),
      body: Center(
        child : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키'
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value.trim().isEmpty){
                    return '키를 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게'
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value.trim().isEmpty){
                    return '몸무게를 입력해주세요';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: (){
                        
                      },
                      child: Text("제출"),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: (){
                        
                      },
                      child: Text("확인"),
                    )
                  ),
                ],
              )
            ],
          )
      )
      /*ListView(
          children: [
            ListTile(
              title: Text("객체 검출(Object Detection)"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PictureDetect())
                );
              }
            ),
            ListTile(
              title: Text("객체 인식(Object Recognition)"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Objectrecognition(cameras))
                );
              }
            )
          ],
        )*/
    );
  }
}