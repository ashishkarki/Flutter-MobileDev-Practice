import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transcationBean.dart';

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

class MyHomePage extends StatelessWidget {
  final List<TransactionBean> transactions = [
    TransactionBean(
      id: "t1",
      title: "Jeans",
      amount: 40.99,
      dateTime: DateTime.now(),
    ),
    TransactionBean(
      id: "t2",
      title: "Groceries",
      amount: 100.15,
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Column(
            children: transactions.map((eachTranscation) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purpleAccent,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${eachTranscation.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          eachTranscation.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            //color: Colors.purpleAccent,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(eachTranscation.dateTime),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
            // <Widget>[
            //   Card(
            //     child: Text('list of transactions'),
            //     color: Colors.red,
            //   ),
            // ],
          ),
        ],
      ),
    );
  }
}
