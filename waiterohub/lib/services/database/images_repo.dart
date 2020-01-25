import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';

class ImagesRepository {
  StorageReference ref = FirebaseStorage.instance.ref();

  Future<String> uploadProductImageAndGetURL(
      File file, String productID) async {
    final StorageUploadTask uploadTask =
        ref.child('product_$productID.jpg').putFile(file);

    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    return await storageSnap.ref.getDownloadURL() as String;
  }

  Future<void> deleteProductImage(String productID) {
    return ref.child('product_$productID.jpg').delete();
  }

  Future<File> compressImage(File pickedImage, String productID) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String path = tempDir.path;

    final im.Image imageFile = im.decodeImage(pickedImage.readAsBytesSync());
    return File('$path/img_$productID.jpg')
        .writeAsBytes(im.encodeJpg(imageFile, quality: 80));
  }
}
