// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';



class VCaptureSend extends StatefulWidget {

  final File imagepath;
  const VCaptureSend({Key key,this.imagepath}) : super(key: key);

  @override
  _VCaptureSend createState() => _VCaptureSend();
}

class _VCaptureSend extends State<VCaptureSend> {


  File _image;
  File _imageFile;

  double _imageWidth;
  double _imageHeight;
  bool _busy = false;

  List _classifiedResult;

  String _result = "";


  @override
  void initState() {
    super.initState();
    // loadImageModel();
  }


  // Future loadImageModel() async {
  //   Tflite.close();
  //   String result;
  //   result = await Tflite.loadModel(
  //     model: "assets/converted_tflite/model_unquant.tflite",
  //     labels: "assets/converted_tflite/labels.txt",
  //   );
  //   print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  //   print(result);
  // }



  // Future<String> classifyImage(image) async {
  //   _classifiedResult = null;
  //   // Run tensorflowlite image classification model on the image
  //   print("classification start $image");
  //   final List result = await Tflite.runModelOnImage(
  //     path: image.path,
  //     numResults: 6,
  //     threshold: 0.05,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //   );
  //   print("classification done");
  //   setState(() {
  //     if (image != null) {
  //       _imageFile = File(image.path);
  //       _classifiedResult = result;
  //
  //       String x = "Confidence : " + result[0]["confidence"].toString() + ", label : " + result[0]["label"].toString();
  //       _result = x;
  //
  //       print(x);
  //       return x;
  //     } else {
  //       print('No image selected.');
  //
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 200,
                  // width: 300,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.file(widget.imagepath),
                ),
                SizedBox(height: 10,),
                RaisedButton(
                    onPressed: () {
                      // classifyImage(widget.imagepath);
                    },
                    child: Text("Upload Image")
                ),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.all(10), child: Text("Result : "  + _result),)
              ],
            )
        ),
      ),
    );
  }
}