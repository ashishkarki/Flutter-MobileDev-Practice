import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/chart_bar.dart';
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

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, txItem) {
      return sum + txItem['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((txObject) {
          print('PRINTED::' +
              maxSpending.toString() +
              (txObject['amount'] as double).toString() +
              ((txObject['amount'] as double) / maxSpending).toString());
          return ChartBarWidget(
            txObject['day'],
            txObject['amount'],
            maxSpending == 0.0
                ? 0.0
                : (txObject['amount'] as double) / maxSpending,
          );
          //Text('${txObject['day']}: ${txObject['amount']}****');
        }).toList(),
      ),
    );
  }
}
