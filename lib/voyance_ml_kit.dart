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
  beginCapture({String country, String documentType, BuildContext context, String secretKey, String accessKey, String responseRoute, String serverURL}){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VCaptureHome(Country: country, DocumentType: documentType, SecretKey: secretKey, AccessKey: accessKey, ResponseRoute: responseRoute)),
    );
  }

  // uploadDocument takes in an Image file, county and documentType as a parameter
  // and upload it to the file server
  int uploadDocument(Image image, String country, String documentType){
    return 200;
  }

  // isImageBlurry takes in an Image file as a parameter
  // and check if the image is blurry by outputting boolean
  bool isImageBlurry(Image image){
    return false;
  }

  // getBlurry takes in an Image file as input and
  // returns a double value of degree of bluriness
  double getBlurry(Image image){
    return 0.2;
  }

  // classifyDocument takes in an image as input
  // then output the type of document in string
  String classifyDocument(Image image){
      return "";
  }

  // takes in an image file and document type as input
  // return a boolean to detect if image is tampered with or not
  bool isTampered(Image image, String documentType){
    return true;
  }

  // takes in an image file as an input
  // return a boolean to check if MRZ is available in the document
  bool mrzChech(Image image){
    return false;
  }


  // takes in an image file as an input
  // return a map containing information of the MRZ
  Map extractMrz(Image image){
    return {};
  }


  // takes in an image file as an input
  // return a boolean to check if Barcode is available in the document
  bool qrCheck(Image image){
    return false;
  }

  // takes in an image file as an input
  // return a string containing information of the code
  String extractQR(Image image){
    return "";
  }



}
