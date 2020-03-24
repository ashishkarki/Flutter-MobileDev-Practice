import 'dart:math';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'models/transcationModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Based Expense Tracker App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTransaction = TransactionModel(
      title: txTitle,
      amount: txAmount,
      id: Random().nextInt(10000).toString(),
      dateTime: DateTime.now(),
    );

    setState(() {
      _userTxnList.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (builderContext) {
        return GestureDetector(
          // onTap: () {}, //avoids closing the sheet if it is tapped
          // behavior: HitTestBehavior.opaque,
          child: NewTransactionWidget(
            addTransactionHandler: _addNewTransaction,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blueGrey,
                child: Text('SOME CHART!!'),
                elevation: 5,
              ),
            ),
            TranscationListWidget(_userTxnList),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
