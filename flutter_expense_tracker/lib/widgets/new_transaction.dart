import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionWidget extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransactionWidget({this.addTransactionHandler});

  @override
  _NewTransactionWidgetState createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends State<NewTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _userSelectedDatetime;

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
    return Card(
      elevation: 6,
      child: Container(
        color: Colors.indigo[50],
        padding: EdgeInsets.all(10),
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
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _displayDatePicker,
                ),
              ],
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
