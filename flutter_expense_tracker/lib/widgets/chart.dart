import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transcationModel.dart';

class ChartWidget extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  ChartWidget(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        final currentTxDatetime = recentTransactions[i].dateTime;
        if (currentTxDatetime.day == weekDay.day &&
            currentTxDatetime.month == weekDay.month &&
            currentTxDatetime.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
