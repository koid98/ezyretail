import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

Future<void> uploadAtchToCloudFunction(
    String url, String docNum, File imageFile) async {
  var uri = Uri.parse(url);
  var request = http.MultipartRequest('POST', uri);

  // Attach the file in the request
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();

  var multipartFile = http.MultipartFile(
    'images[]', // This should match the key in the API
    stream,
    length,
    filename: basename(imageFile.path),
  );

  request.fields["doc_no"] = docNum;

  request.files.add(multipartFile);

  // Send the request
  await request.send();
  // var response = await request.send();

/*  if (response.statusCode == 200) {
    print('Upload successful');
    // Optionally, parse the response
    */ /*var responseBody = await response.stream.bytesToString();
    print(responseBody);*/ /*
  } else {
    print('Upload failed with status: ${response.statusCode}');
  }*/
}

Future<void> uploadAtchToLinkToolsFunction(
    String url, String host, String key, String docNum, File imageFile) async {
  var uri = Uri.parse(url);
  var request = http.MultipartRequest('POST', uri);

  // Attach the file in the request
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();

  var multipartFile = http.MultipartFile(
    'imgFile', // This should match the key in the API
    stream,
    length,
    filename: basename(imageFile.path),
  );

  request.fields["doc_no"] = docNum;
  request.fields["host"] = host;
  request.fields["key"] = key;

  request.files.add(multipartFile);

  // Send the request
  // await request.send();
  var response = await request.send();

  if (response.statusCode == 200) {
    print('Upload successful');
    // Optionally, parse the response
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
  } else {
    print('Upload failed with status: ${response.statusCode}');
  }
}
