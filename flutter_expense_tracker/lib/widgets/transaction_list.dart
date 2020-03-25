import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:intl/intl.dart';

import '../models/transcationModel.dart';

class TranscationListWidget extends StatelessWidget {
  final List<TransactionModel> _userTxnList;
  final Function _deleteTransaction;

  TranscationListWidget(
    this._userTxnList,
    this._deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    final mediaQryCtx = MediaQuery.of(context);

    return _userTxnList.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions yet. Add Now.',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // to stop the image from overflowing
                  height: constraints.maxHeight * TX_LIST_IMAGE_PERCENT,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    //fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            // Note: ListView takes up all the availble space
            itemBuilder: (buildContext, itemIndex) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: FittedBox(
                        child: Text(
                            '$CURRENT_CURRENCY_SYMBOL${_userTxnList[itemIndex].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTxnList[itemIndex].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_userTxnList[itemIndex].dateTime),
                  ),
                  trailing: mediaQryCtx.size.width > DELETE_TEXT_SHOW_SIZE
                      ? FlatButton.icon(
                          onPressed: () =>
                              _deleteTransaction(_userTxnList[itemIndex].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete Tx'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_userTxnList[itemIndex].id),
                        ),
                ),
              );
            },
            itemCount: _userTxnList.length,
            //children: _userTxnList.map((eachTranscation) {}).toList(),
          );
  }
}
