import 'package:flutter/material.dart';

import './constants.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
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
  var _showChart = false;

  List<TransactionModel> get _recentTransactions {
    return _userTxnList.where((transaction) {
      return transaction.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

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

  void _deleteTransaction(String deletedItemId) {
    setState(() {
      _userTxnList.removeWhere((tx) => tx.id == deletedItemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final myAppBar = AppBar(
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

    final appBodyHeightOnly = (MediaQuery.of(context).size.height -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    final curScaleFactor =
        MediaQuery.of(context).textScaleFactor; // TODO: SEE WHERE TO USE
    final chartWidgetExpression = Container(
      height: appBodyHeightOnly * 0.3,
      child: ChartWidget(_recentTransactions),
    );
    final txWidgetExpression = Container(
      height: appBodyHeightOnly * TX_LIST_HEIGHT_PERCENT,
      child: TranscationListWidget(_userTxnList, _deleteTransaction),
    );

    return Scaffold(
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (newVal) {
                        setState(() {
                          _showChart = newVal;
                        });
                      }),
                ],
              ),
            if (!isLandscapeMode) chartWidgetExpression,
            if (!isLandscapeMode) txWidgetExpression,
            if (isLandscapeMode)
              _showChart
                  ? chartWidgetExpression // chart widget
                  : txWidgetExpression,
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
