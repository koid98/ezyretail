import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> writeLicenseKey(String licenseKey) async {
  final dir = await getApplicationDocumentsDirectory(); // Get App Storage
  final file = File('${dir.path}/license.txt'); // Define file path
  return file.writeAsString(licenseKey); // Write key to file
}

Future<String?> readLicenseKey() async {
  final dir = await getApplicationDocumentsDirectory(); // Get App Storage
  final file = File('${dir.path}/license.txt'); // Define file path

  if (await file.exists()) {
    return await file.readAsString(); // Read file content
  } else {
    return null; // Return null if file doesn't exist
  }
}

Future<void> deleteLicenseFile() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/license.txt');

  if (await file.exists()) {
    await file.delete();
  }
}
