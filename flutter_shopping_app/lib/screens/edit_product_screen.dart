import 'package:flutter/material.dart';

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
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      textInputAction:
          textInputAction, // what will the soft keyboard show as next action
      keyboardType: textInputType,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmit,
      focusNode: focusNode,
      controller: textEditingController,
    );
  }

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
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

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);

    print('image: ${_imageUrlController.text.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _textInputBuilder(
                  labelText: 'Title',
                  onFieldSubmit: (_) {
                    focusScope.requestFocus(_priceFocusNode);
                  },
                ),
                _textInputBuilder(
                    labelText: 'Price',
                    textInputType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmit: (_) {
                      focusScope.requestFocus(_descriptionFocusNode);
                    }),
                _textInputBuilder(
                  labelText: 'Description',
                  maxLines: 3,
                  textInputType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
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
                      ),
                    ), // to show preview
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
