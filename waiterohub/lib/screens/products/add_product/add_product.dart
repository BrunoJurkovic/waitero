import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as im;
import 'package:uuid/uuid.dart';
import 'package:waitero/services/database/images_repo.dart';
import 'package:waitero/services/database/products_repo.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({this.price, this.name, this.id, this.imageUrl});

  @override
  _AddProductPageState createState() => _AddProductPageState();

  final String price;
  final String name;
  final String id;
  final String imageUrl;
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 32,
            onPressed: () {
              Router.navigator.pop();
            },
          ),
          Expanded(
              child: _AddProductForm(
            id: widget.id,
            price: widget.price,
            imageUrl: widget.imageUrl,
            name: widget.name,
          )),
        ],
      ),
    );
  }
}

class _AddProductForm extends StatefulWidget {
  const _AddProductForm({this.price, this.name, this.id, this.imageUrl});

  final String price;
  final String name;
  final String id;
  final String imageUrl;

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<_AddProductForm> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  final FocusNode _productNameFocus = FocusNode();
  final FocusNode _productPriceFocus = FocusNode();
  final StorageReference ref = StorageBucket().instance;
  final CollectionReference products = ProductsRepo().ref;

  File _pickedImage;
  String productId;
  bool isUploading = false;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    setState(() {
      _productName.text = widget.name ?? '';
      _productPrice.text = widget.price.substring(0, widget.price.length - 1) ?? '0.00';
      productId = widget.id ?? Uuid().v4();
      imageUrl = widget.imageUrl ?? widget.imageUrl;
    });
  }

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productNameFocus.dispose();
    _productPriceFocus.dispose();
    super.dispose();
  }

  Future<void> compressImage() async {
    final Directory tempDir = await getTemporaryDirectory();
    final String path = tempDir.path;

    final im.Image imageFile = im.decodeImage(_pickedImage.readAsBytesSync());
    final File compressedImageFile = File('$path/img_$productId.jpg')
      ..writeAsBytesSync(
        im.encodeJpg(imageFile, quality: 80),
      );
    setState(() {
      _pickedImage = compressedImageFile;
    });
  }

  void changeFieldFocus(FocusNode oldFocus, FocusNode newFocus) {
    oldFocus.unfocus();
    newFocus.requestFocus();
  }

  Future<void> getProductImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = image;
    });
  }

  Future<void> handleDelete(String id) async {
    setState(() {
      isUploading = true;
    });
    await ref.child('product_$productId.jpg').delete();
    await products.document(productId).delete();
    Router.navigator.pop(id);
    setState(() {
      isUploading = false;
    });
  }

  Future<void> handleSubmit() async {
    String mediaUrl = '';
    setState(() {
      isUploading = true;
    });
    if (imageUrl == null) {
      mediaUrl = await uploadImage(_pickedImage);
      await compressImage();
    }
    else {
      mediaUrl = imageUrl;
    }
    createPostInFirestore(
      mediaUrl: mediaUrl,
      name: _productName.text,
      price: _productPrice.text,
    );
  }

  Future<String> uploadImage(File file) async {
    final StorageUploadTask uploadTask =
        ref.child('product_$productId.jpg').putFile(file);

    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    final String downloadUrl = await storageSnap.ref.getDownloadURL() as String;

    return downloadUrl;
  }

  Future<void> createPostInFirestore(
      {String mediaUrl, String price, String name}) {
    products.document(productId).setData(<String, String>{
      'productId': productId,
      'imageUrl': mediaUrl,
      'name': _productName.text,
      'price': '${_productPrice.text}\$',
    });
    _productName.clear();
    _productPrice.clear();
    setState(() {
      _pickedImage = null;
      isUploading = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width / 40;
    return isUploading
        ? Center(
            child: Container(
              child: const CircularProgressIndicator(),
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          )
        : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            children: <Widget>[
              TextFormField(
                autofocus: true,
                autocorrect: false,
                focusNode: _productNameFocus,
                controller: _productName,
                textCapitalization: TextCapitalization.words,
                onChanged: (String text) {},
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'You must choose a product name';
                  }
                  return null;
                },
                style: TextStyle(fontSize: fontSize),
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (_) =>
                    changeFieldFocus(_productNameFocus, _productPriceFocus),
              ),
              const SizedBox(height: 50),
              TextFormField(
                autocorrect: false,
                focusNode: _productPriceFocus,
                controller: _productPrice,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: fontSize),
                decoration: const InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),
              FormField<File>(
                validator: (File file) {
                  if (file == null) {
                    return 'You must pick an image';
                  }
                  return null;
                },
                builder: (FormFieldState<File> state) {
                  return InkWell(
                    onTap: getProductImage,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Product Image',
                        errorText: state.errorText,
                        border: const OutlineInputBorder(),
                      ),
                      baseStyle: TextStyle(
                        fontSize: fontSize,
                      ),
                      child: _pickedImage != null
                          ? Text(
                              path.basenameWithoutExtension(_pickedImage.path),
                              style: TextStyle(fontSize: fontSize),
                            )
                          : Text(
                              'Pick an image',
                              style: TextStyle(fontSize: fontSize),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: _pickedImage != null
                      ? Image(
                          image: FileImage(_pickedImage),
                        )
                      : imageUrl == null
                          ? Text(
                              'Select an image',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold),
                            )
                          : Image(
                              image: NetworkImage(imageUrl),
                            ),
                ),
              ),
              FlatButton(
                color: Colors.blueAccent,
                onPressed: () {
                  if (_pickedImage == null ||
                      _productName == null ||
                      _productPrice == null) {
                    // TODO: Add dialog.
                  } else {
                    handleSubmit();
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
              widget.imageUrl == null ? SizedBox() : FlatButton(
                color: Colors.redAccent,
                onPressed: () {
                  handleDelete(productId);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          );
  }
}
