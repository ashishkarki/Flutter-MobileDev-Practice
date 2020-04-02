import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/constants.dart';
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
    String initialValue,
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
      initialValue: initialValue,
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

  var _initProductValues = {
    'title': '',
    'description': '',
    'price': 0.0,
    'imageUrl': '',
  };

// to stop didChangeDependencies from running unnecessarily
  var _isInit = true;

  // to show a loading spinner while async requests are processing
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if ((ModalRoute.of(context).settings.arguments as Map) != null) {
        final productIdFromUserProductScreen =
            (ModalRoute.of(context).settings.arguments as Map)['id'];
        final productToBeEdited =
            Provider.of<ProductsProvider>(context, listen: false)
                .findById(productIdFromUserProductScreen);
        _editedProduct = productToBeEdited; // load the product into this form
        _initProductValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl, // since it has a controller, we don't do this
          'imageUrl': '',
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
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
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isFormValid =
        _form.currentState.validate(); // triggers all validators below

    if (!isFormValid) {
      return;
    }

    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    try {
      if (_editedProduct.id != null && _editedProduct.id.isNotEmpty) {
        // means this is a pre-existing, edited product
        await productsProvider.updateProduct(_editedProduct.id, _editedProduct);
      } else {
        await productsProvider.addProduct(_editedProduct);
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(REST_REQUEST_ERROR_TITLE),
          content: Text(error.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () {
                // once this pops, showDialog resolves and returns a Future
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });

      // once saving is done, go back to products list page
      Navigator.of(context).pop();
    }
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _textInputBuilder(
                        initialValue: _initProductValues['title'],
                        labelText: 'Title',
                        onFieldSubmit: (_) {
                          focusScope.requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
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
                        initialValue: _initProductValues['price'].toString(),
                        labelText: 'Price',
                        textInputType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmit: (_) {
                          focusScope.requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
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
                        initialValue: _initProductValues['description'],
                        labelText: 'Description',
                        maxLines: 3,
                        textInputType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
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
                              // since there is a controller, can't set initialValue
                              // initialValue: _initProductValues['imageUrl'],
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
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
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
