import 'package:flutter/material.dart';

import 'new_transaction.dart';
import 'transaction_list.dart';
import '../models/transcationModel.dart';

class UserTransactionWidget extends StatefulWidget {
  @override
  _UserTransactionWidgetState createState() => _UserTransactionWidgetState();
}

class _UserTransactionWidgetState extends State<UserTransactionWidget> {
  final List<TransactionModel> _userTxnList = [
    TransactionModel(
      id: "t1",
      title: "Jeans",
      amount: 40.99,
      dateTime: DateTime.now(),
    ),
    TransactionModel(
      id: "t2",
      title: "Groceries",
      amount: 100.15,
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NewTransactionWidget(),
      TranscationListWidget(_userTxnList),
    ]);
  }
}
