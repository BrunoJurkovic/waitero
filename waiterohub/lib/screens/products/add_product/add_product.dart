import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/no_nav_scaffold.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:uuid/uuid.dart';
import 'package:waitero/services/database/images_repo.dart';
import 'package:waitero/services/database/products_repo.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({this.price, this.name, this.id, this.imageUrl});
  
  final String price;
  final String name;
  final String id;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return NoNavScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 32,
                  onPressed: () {
                    Router.navigator.pop();
                  },
                ),
                const SizedBox(width: 8),
                if (name == null) const Text(
                  'Add New Product',
                  style: TextStyle(fontSize: 32),
                ) else Text(
                  'Manage "${name.trim()}"',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: _AddProductForm(
              id: id,
              price: price,
              imageUrl: imageUrl,
              name: name,
            ),
          ),
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

  ImagesRepository _imagesRepository;
  ProductsRepository _productsRepository;

  File _pickedImage;
  String _productID;
  bool _isLoading = false;
  String _imageUrl;

  @override
  void initState() {
    super.initState();
    _productName.text = widget.name ?? '';
    _productPrice.text =
        widget.price?.substring(1, widget.price.length) ?? '0.00';
    _productID = widget.id ?? Uuid().v4();
    _imageUrl = widget.imageUrl ?? widget.imageUrl;
    _imagesRepository = Provider.of<ImagesRepository>(context, listen: false);
    _productsRepository = Provider.of<ProductsRepository>(context, listen: false);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productNameFocus.dispose();
    _productPriceFocus.dispose();
    super.dispose();
  }

  void changeFieldFocus(FocusNode oldFocus, FocusNode newFocus) {
    oldFocus.unfocus();
    newFocus.requestFocus();
  }

  Future<void> pickProductImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = image;
    });
  }

  Future<void> handleDelete() async {
    setState(() {
      _isLoading = true;
    });
    await _productsRepository.deleteProduct(_productID);
    setState(() {
      _isLoading = false;
    });
    Router.navigator.pop(_productID);
  }

  Future<void> handleSubmit() async {
    String mediaUrl = '';
    setState(() {
      _isLoading = true;
    });
    if (_imageUrl == null) {
      mediaUrl = await _imagesRepository.uploadProductImageAndGetURL(
        _pickedImage,
        _productID,
      );
      await compressImage();
    } else {
      mediaUrl = _imageUrl;
    }
    final Product product = Product(
      id: _productID,
      imageUrl: mediaUrl,
      name: _productName.text,
      price: '\$${_productPrice.text}',
    );
    createProduct(product);
  }

  Future<void> compressImage() async {
    final File compressedImageFile =
        await _imagesRepository.compressImage(_pickedImage, _productID);
    setState(() {
      _pickedImage = compressedImageFile;
    });
  }

  Future<void> createProduct(Product product) async {
    await _productsRepository.createProduct(product);
    _productName.clear();
    _productPrice.clear();
    setState(() {
      _pickedImage = null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return buildLoadingIndicator(context);
    } else {
      return buildForm(context);
    }
  }

  Widget buildForm(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width / 40;

    return ListView(
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
              onTap: pickProductImage,
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
                : _imageUrl == null
                    ? Text(
                        'Select an image',
                        style: TextStyle(
                            fontSize: fontSize, fontWeight: FontWeight.bold),
                      )
                    : CachedNetworkImage(imageUrl: _imageUrl, placeholder: (BuildContext ctx, _) {return buildLoadingIndicator(context);},),
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
        if (widget.imageUrl == null)
          const SizedBox()
        else
          FlatButton(
            color: Colors.redAccent,
            onPressed: handleDelete,
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

  Center buildLoadingIndicator(BuildContext context) {
    return Center(
      child: Container(
        child: const CircularProgressIndicator(),
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.08,
      ),
    );
  }
}
