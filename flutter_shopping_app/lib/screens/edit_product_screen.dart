import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit-product-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Widget _textInputBuilder({
    String labelText,
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType textInputType = TextInputType.text,
    int maxLines,
    FocusNode focusNode,
    Function onFieldSubmit,
    TextEditingController textEditingController,
    Function onSaved,
    Function validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: TextStyle(color: Colors.red),
      ),
      textInputAction:
          textInputAction, // what will the soft keyboard show as next action
      keyboardType: textInputType,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmit,
      focusNode: focusNode,
      controller: textEditingController,
      onSaved: onSaved,
      validator: validator,
    );
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      final valStr = _imageUrlController.text.toString();
      if (valStr.isEmpty &&
          (!valStr.startsWith('http') || !valStr.startsWith('https')) &&
          (!valStr.endsWith('.jpg') || !valStr.endsWith('.jpeg'))) {
        return;
      }

      setState(() {}); // do nothing, just update the state to trigger changes
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isFormValid =
        _form.currentState.validate(); // triggers all validators below

    if (!isFormValid) {
      return;
    }

    _form.currentState.save();
    // print(_editedProduct.title);
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);

    Provider.of<ProductsProvider>(context, listen: false)
        .addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _textInputBuilder(
                  labelText: 'Title',
                  onFieldSubmit: (_) {
                    focusScope.requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: null,
                      title: value,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    print('validator in Title with value: $value');
                    // return null; // means no error
                    //return 'this is error'; // means an error
                    if (value.isEmpty) {
                      return 'Please provide a product Name!!';
                    }
                    return null;
                  },
                ),
                _textInputBuilder(
                  labelText: 'Price',
                  textInputType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmit: (_) {
                    focusScope.requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: null,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value),
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    // return null; // means no error
                    //return 'this is error'; // means an error
                    if (value.isEmpty) {
                      return 'Please provide a product Price!!';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(value) <= 0.0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                ),
                _textInputBuilder(
                  labelText: 'Description',
                  maxLines: 3,
                  textInputType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: null,
                      title: _editedProduct.title,
                      description: value,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
                  validator: (value) {
                    // return null; // means no error
                    //return 'this is error'; // means an error
                    if (value.isEmpty) {
                      return 'Please provide a product Description!!';
                    }
                    if (value.toString().length < 10) {
                      return 'Please enter Description longer than 10 charaters';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Flexible(
                      child: _textInputBuilder(
                        labelText: 'Image URL',
                        textInputType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        textEditingController: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmit: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: null,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value,
                          );
                        },
                        validator: (value) {
                          // return null; // means no error
                          //return 'this is error'; // means an error
                          if (value.isEmpty) {
                            return 'Please provide a product ImageUrl!!';
                          }
                          final valStr = value.toString();
                          // if (!valStr.startsWith('http') &&
                          //     !valStr.startsWith('https')) {
                          //   return 'Please enter a valid URL';
                          // }
                          // if (!valStr.endsWith('.png') &&
                          //     !valStr.endsWith('.jpg') &&
                          //     !valStr.endsWith('.jpeg')) {
                          //   return 'Please enter a valid URL';
                          // }
                          var urlPattern =
                              r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                          var result =
                              new RegExp(urlPattern, caseSensitive: false)
                                  .firstMatch(valStr);
                          if (result == null) {
                            return 'Please enter a valid image URL';
                          }
                          return null;
                        },
                      ),
                    ),
                    // to show preview
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
