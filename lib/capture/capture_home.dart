import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voyance_ml_kit/capture/capture_send.dart';

class VCaptureHome extends StatefulWidget {

  final String Country;
  final String DocumentType;
  final String SecretKey;
  final String AccessKey;
  final String ResponseRoute;
  final String ServerURL;

  const VCaptureHome({Key key,this.Country, this.DocumentType, this.SecretKey, this.AccessKey, this.ResponseRoute, this.ServerURL}) : super(key: key);


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

    return Column(
      children: [

        FlatButton(
          child: Text(
            'Camera',
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
          ),

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

    if (area == null) {
      // cannot crop, widget is not setup
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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VCaptureSend(imagepath: _lastCropped, DocumentType: widget.DocumentType, Country: widget.Country, AccessKey: widget.AccessKey, SecretKey: widget.SecretKey, ResponseRoute: widget.ResponseRoute, ServerURL: widget.ServerURL )),
    );
  }
}
