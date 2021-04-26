// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:opencv/opencv.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class VCaptureSend extends StatefulWidget {

  final File imagepath;
  final String Country;
  final String DocumentType;
  final String SecretKey;
  final String AccessKey;
  final String ResponseRoute;
  final String ServerURL;

  const VCaptureSend({Key key,this.imagepath, this.Country, this.DocumentType, this.AccessKey, this.SecretKey, this.ResponseRoute, this.ServerURL}) : super(key: key);

  @override
  _VCaptureSend createState() => _VCaptureSend();
}

class _VCaptureSend extends State<VCaptureSend> {
  static const MethodChannel _channel =   const MethodChannel('voyance');

  @override
  void initState() {
    super.initState();
  }

  static Future<bool> isImageBlurry(String path) async {
    final int result = await _channel.invokeMethod("isImageBlurry", {"filePath": path});
    if(result == 1){
      return true;
    }else if(result == -1){
      throw("Cannot continue operation");
    } else {
      return false;
    }
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
                    onPressed: () async{
                      // classifyImage(widget.imagepath);
                      // print(widget.Token);
                      // print(widget.Country);
                      // print(widget.DocumentType);
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                      bool res = await isImageBlurry(widget.imagepath.path);
                      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                      print(res);

                      return;

                      Response response;
                      var dio = Dio();

                      try {
                        //404
                        var formData = FormData.fromMap({
                          'country': widget.Country,
                          'document_type': widget.DocumentType,
                          'file': await MultipartFile.fromFile(widget.imagepath.path,filename: 'image.png')
                        });
                        response = await dio.post(
                            widget.ServerURL,
                            data: formData,
                            options: Options(
                              headers: {
                                "X-Access-Key": widget.AccessKey,
                                "X-Secret-Key" :widget.SecretKey
                              },
                          ),
                        );

                        print("Success");
                       Navigator.pushNamed(context, widget.ResponseRoute,arguments: {'status' : response.statusCode});


                      } on DioError catch (e) {
                        // The request was made and the server responded with a status code
                        // that falls out of the range of 2xx and is also not 304.
                        if (e.response != null) {
                          Navigator.pushNamed(context, widget.ResponseRoute,arguments: {'status' : e.response.statusCode});
                          print(" >>>>>>>>>>>>>> " + e.response.statusCode.toString());

                        } else {
                          // Something happened in setting up or sending the request that triggered an Error
                          Navigator.pushNamed(context, widget.ResponseRoute,arguments: {'status' : e.response.statusCode});
                          print(" <<<<<<<<<<<<<<<< " + e.response.statusCode.toString());
                        }
                      }


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