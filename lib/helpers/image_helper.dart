import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";

class ImageHelper {
  static const String itemImageFolder = "StockItemImage";
  static const String customerImageFolder = "CustomerImage";
  static const String paymentModeImageFolder = "PaymentModeImage";
  static const String menuHeaderImageFolder = "MenuHeaderImage";
  static const String menuDetailImageFolder = "MenuDetailImage";
  static const String companyImageFolder = "CompanyImage";

  static Image imageFromBase64String(String base64String) {
    if (base64String == "" || base64String.isEmpty) {
      return Image.asset(
        "assets/images/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
      );
    }
  }

  static Image imageFromStorage(String imagePath) {
    if (imagePath == "" || imagePath.isEmpty) {
      return Image.asset(
        "assets/images/no_image.png",
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  //Store image to the Storage
  static Future<String> storeImageToFile(
      String imageFolder, String itemCode, String base64Image) async {
    Uint8List imageBytes = base64.decode(base64Image);

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath = "${appDocDir.path}/$imageFolder";

    String encodeItemCode = Uri.encodeComponent(itemCode);

    String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

    // Ensure the directory exists before writing the file
    await Directory(documentsDirectoryPath).create(recursive: true);

    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes);
    return imagePath;
  }

  //Remove all images from Specific folder
  static Future<void> clearItemFolder(String imageFolder) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath = "${appDocDir.path}/$imageFolder";

    //Check if the directory exists
    if (await Directory(documentsDirectoryPath).exists()) {
      //Delete the directory
      await Directory(documentsDirectoryPath).delete(recursive: true);
    }
  }

  static Future<String> checkImageExist(String itemCode) async {
    String tempPath = "";
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath = "${appDocDir.path}/$itemImageFolder";

    String encodeItemCode = Uri.encodeComponent(itemCode);

    String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

    bool isExist = await File(imagePath).exists();

    if (isExist) {
      tempPath = imagePath;
    }

    return tempPath;
  }

  //Remove image from the ItemImage folder
  static Future<void> removeItemImage(String itemCode) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath = "${appDocDir.path}/$itemImageFolder";

    String encodeItemCode = Uri.encodeComponent(itemCode);

    String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

    //Check if the file exists
    if (await File(imagePath).exists()) {
      //Delete the file
      await File(imagePath).delete();
    }
  }

  //Grey Filter
  static const ColorFilter greyFilter = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ]);
}
