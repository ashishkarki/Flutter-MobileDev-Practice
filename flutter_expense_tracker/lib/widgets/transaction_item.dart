import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/transcationModel.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({
    Key key,
    @required this.userTransaction,
    @required this.themeCtx,
    @required this.mediaQryCtx,
    @required this.deleteTransaction,
  }) : super(key: key);

  final TransactionModel userTransaction;
  final ThemeData themeCtx;
  final MediaQueryData mediaQryCtx;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
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
                  '$CURRENT_CURRENCY_SYMBOL${userTransaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: themeCtx.textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.dateTime),
        ),
        trailing: mediaQryCtx.size.width > DELETE_TEXT_SHOW_SIZE
            ? FlatButton.icon(
                onPressed: () => deleteTransaction(userTransaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete Tx'),
                textColor: themeCtx.errorColor,
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: themeCtx.errorColor,
                onPressed: () => deleteTransaction(userTransaction.id),
              ),
      ),
    );
  }
}
