// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';



class VCaptureSend extends StatefulWidget {

  final File imagepath;
  final String Country;
  final String DocumentType;
  final String Token;

  const VCaptureSend({Key key,this.imagepath, this.Country, this.DocumentType, this.Token}) : super(key: key);

  @override
  _VCaptureSend createState() => _VCaptureSend();
}

class _VCaptureSend extends State<VCaptureSend> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Voyance Data Collection'),
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
                      print(widget.Token);
                      print(widget.Country);
                      print(widget.DocumentType);
                    },
                    child: Text("Upload Image")
                ),
                SizedBox(height: 10,),
              ],
            )
        ),
      ),
    );
  }
}