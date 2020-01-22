import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/routing/router.gr.dart';

class AddProductPage extends StatelessWidget {
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
          const Expanded(child: _AddProductForm()),
        ],
      ),
    );
  }
}

class _AddProductForm extends StatefulWidget {
  const _AddProductForm({Key key}) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<_AddProductForm> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  final FocusNode _productNameFocus = FocusNode();
  final FocusNode _productPriceFocus = FocusNode();

  File _pickedImage;

  @override
  void initState() {
    super.initState();
    // _productName.text = '';
    // _productPrice.text = '0.0';
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

  Future<void> getProductImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ? Image(image: FileImage(_pickedImage))
                : Text(
                    'Select an image',
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
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
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
