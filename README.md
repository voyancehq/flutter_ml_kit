# Voyance ML Kit

Voyance ML Kit is a flutter SDK developed to perform machine learning capabilities from your mobile device.

This current version of the SDK only data collection process.


## Installation
The SDK is only available from github and not pub.dev.

1. Due to the camera usage, we will need to update the gradle file and increase minSdkVersion value to an higer version.

    from your project directory, open `android/app/build.gradle` file and change the `minSdkVersion` number to 21 as below.

    ```
    defaultConfig {
        minSdkVersion 21
        ...
    }
    ```

2. open the `pubsec.yaml` file in your project and add the plugin in the format below.
    ```
    dependencies:
      flutter:
        sdk: flutter
      voyance_ml_kit:
        git:
          url: git://github.com/voyancehq/flutter_ml_kit.git
          ref: master
    ```

## Implementation
```
// import the ml kit
import 'package:voyance_ml_kit/voyance_ml_kit.dart';

// the block of code is all you need from your application logic to trigger
// the sdk with the below parameters
onPressed: (){
  String country = "Nigeria";
  String documentType = "International Passport";
  String accessKey = "3959595955";
  String secretKey = "49595969695";
  String responseRoute = "/success-upload";
  MLKit().beginCapture(context: context, country: "NG", documentType: documentType, accessKey: accessKey, secretKey:secretKey, responseRoute: responseRoute);
},

```
