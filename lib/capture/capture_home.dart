import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voyance_ml_kit/capture/capture_send.dart';
// import 'package:voyanceapp/Page2.dart';

// import 'camera.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarBrightness: Brightness.dark,
//     statusBarIconBrightness: Brightness.light,
//     systemNavigationBarIconBrightness: Brightness.light,
//   ));
//
//   // runApp(new MyApp());
//   runApp(MaterialApp(
//     title: "App",
//     debugShowCheckedModeBanner: false,
//     home: MyApp(),
//   ));
// }

class VCaptureHome extends StatefulWidget {
  @override
  _VCaptureHome createState() => new _VCaptureHome();
}

class _VCaptureHome extends State<VCaptureHome> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;


  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
    // );



    // return SafeArea(
    //     child: Container(
    //       color: Colors.black,
    //       padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
    //       child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
    //     ),
    //   );

    // );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey,),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    // return FlatButton(
    //   child: Text(
    //     'Open Image',
    //     style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
    //   ),
    //   onPressed: () => _openImage(),
    // );
    return Column(
      children: [

        //   Container(
        //       height: 200,
        //       // width: 300,
        //       alignment: Alignment.topLeft,
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //       ),
        //     child: _lastCropped != null ? Image.file(_lastCropped) : SizedBox(),
        //   ),
        // SizedBox(height: 10,),
        FlatButton(
          child: Text(
            'Camera',
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
          ),
          // onPressed: () => _openImage(),
          //   onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Camera()),
          // );
          onPressed: () => _openImage(1),

        ),
        FlatButton(
          child: Text(
            'Open Image',
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
          ),
          onPressed: () => _openImage(2),
        ),
      ],
    );
  }

  Future<void> _openImage(int type) async {
    final file = await ImagePicker.pickImage(source: type == 1 ? ImageSource.camera : ImageSource.gallery);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    print(">>>>>>>>>>>>>>>>>.");
    print(area.width);
    print(area.height);
    print("<<<<<<<<<<<<<<<<<<<<<");
    if (area == null) {
      // cannot crop, widget is not setup
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>> ");
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,

    );

    sample.delete();


    _lastCropped?.delete();
    _lastCropped = file;

    debugPrint('$file');

    // setState(() {
    //   _sample = null;
    // });


    print('$_file');
    print(" >>> " +_lastCropped.path);


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VCaptureSend(imagepath: _lastCropped)),
    );
  }
}
