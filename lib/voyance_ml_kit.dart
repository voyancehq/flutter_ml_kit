library voyance_ml_kit;
import 'package:voyance_ml_kit/capture/capture_home.dart';
import 'package:flutter/material.dart';

/// A Calculator.
class MLKit {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  initialize({String secretKey, String publicKey}){
    print("This is great > " + secretKey + " -- " + publicKey);
  }

  // beginCapture is a method that allow
  // uploading of image
  beginCapture({String country, String documentType, BuildContext context, String requestToken}){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VCaptureHome(Country: country, DocumentType: documentType, Token: requestToken)),
    );
  }
}
