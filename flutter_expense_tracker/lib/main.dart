import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/main_body.dart';

import './constants.dart';
import './widgets/new_transaction.dart';
import 'models/transcationModel.dart';

void main() => runApp(MyApp());

// void main() {
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME_STRING,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        errorColor: Colors.redAccent,
        fontFamily: 'Baloo2',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _userTxnList = [];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime txDateTime) {
    final newTransaction = TransactionModel(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      dateTime: txDateTime,
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
    final PreferredSizeWidget myAppBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(APP_NAME_STRING),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction,
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              APP_NAME_STRING,
              style: TextStyle(
                fontFamily: 'Baloo2',
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => _startAddNewTransaction(context))
            ],
          );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: MainBodyWidget(myAppBar, _userTxnList),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: myAppBar,
          )
        : Scaffold(
            appBar: myAppBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
