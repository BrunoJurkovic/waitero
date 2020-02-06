import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';

/*
  ! This repo is used for all things related to images (compressing, uploading, returning a URL, etc.).
  ? Ovaj repository se koristi za sve stvari vezane za slike (kompresiranje, uploadanje, dohvacanje URL-a, itd.).
*/

class ImagesRepository {
  /*
  ! We get a reference to the storage bucket.
  ? Dobijemo referencu za storage bucket.
*/
  StorageReference ref = FirebaseStorage.instance.ref();

  ///!EN: This function uploads a image that we provide it, sets the name of the to-be-uplaoded file, then it returns a URL.
  ///?HR: Ova funkcija uploada sliku koju joj posaljemo, postavi zadano ime slike koja ce biti uploadana, i onda nam vrati URL.

  Future<String> uploadProductImageAndGetURL(
      File file, String productID) async {
    final StorageUploadTask uploadTask =
        ref.child('product_$productID.jpg').putFile(file);

    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    return await storageSnap.ref.getDownloadURL() as String;
  }

  ///!EN: This function deleted the image with the provided product ID.
  ///
  ///?HR: Ova funkcija izbrise sliku sa zadanim ID-em proizvoda.
  Future<void> deleteProductImage(String productID) {
    return ref.child('product_$productID.jpg').delete();
  }

  ///! This function first gets a temp directory on the device, the saves a path to the directory,
  ///! then, saves the image as a list of bytes, then re-writes the image but with a set quality
  ///! of 80%, and returns the image.
  ///
  ///? Ova funkcija prvo nabavi lokalni directory na uredaju, onda nabavi 'path' do te lokacije, 
  ///? onda spremi sliku kao listu byteova, onda je ponovno spremi kao sliku ali sa kvalitetom
  ///? od 80%, i onda vrati sliku.
  Future<File> compressImage(File pickedImage, String productID) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String path = tempDir.path;

    final im.Image imageFile = im.decodeImage(pickedImage.readAsBytesSync());
    return File('$path/img_$productID.jpg')
        .writeAsBytes(im.encodeJpg(imageFile, quality: 80));
  }
}
