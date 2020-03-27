import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class NewTransactionWidget extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransactionWidget({this.addTransactionHandler}) {
    //print('Constructor NewTransactionWidget');
  }

  @override
  _NewTransactionWidgetState createState() {
    //print('createState NewTransactionWidget');
    return _NewTransactionWidgetState();
  }
}

class _NewTransactionWidgetState extends State<NewTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _userSelectedDatetime;

  _NewTransactionWidgetState() {
    //print('Constructor _NewTransactionWidgetState');
  }

  @override
  void initState() {
    super.initState();
    //print('initState() _NewTransactionWidgetState');
  }

  @override
  void didUpdateWidget(NewTransactionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //print('didUpdateWidget() _NewTransactionWidgetState');
  }

  @override
  void dispose() {
    super.dispose();
    //print('dispose() _NewTransactionWidgetState');
  }

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _userSelectedDatetime == null) {
      return;
    }

    widget.addTransactionHandler(_titleController.text,
        double.parse(_amountController.text), _userSelectedDatetime);

    // closes the topmost model that is displayed in this case the bottom sheet
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    final now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year), // int y, int m, int d
      lastDate: now,
    ).then((selectedDatetime) {
      if (selectedDatetime == null) return;

      setState(() {
        _userSelectedDatetime = selectedDatetime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() NewTransactionWidget');
    final themeCtx = Theme.of(context);
    final mediaQryCtx = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          color: Colors.indigo[50],
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQryCtx.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    // causes text to take all the free space which pushes the button below to the right
                    child: Text(
                      _userSelectedDatetime == null
                          ? 'No Date Selected'
                          : 'Selected Date: ${DateFormat.yMd().format(_userSelectedDatetime)}',
                    ),
                  ),
                  AdaptiveFlatButtonWidget(
                    'Select Date',
                    this._displayDatePicker,
                  ),
                ],
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                color: themeCtx.primaryColor,
                textColor: themeCtx.textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
