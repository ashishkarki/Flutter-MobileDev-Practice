import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButtonWidget extends StatelessWidget {
  final String text;
  final Function _displayDatePicker;

  AdaptiveFlatButtonWidget(this.text, this._displayDatePicker);

  @override
  Widget build(BuildContext context) {
    print('build() AdaptiveFlatButtonWidget');
    final themeCtx = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: null,
          )
        : FlatButton(
            textColor: themeCtx.primaryColor,
            child: Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: _displayDatePicker,
          );
  }
}
