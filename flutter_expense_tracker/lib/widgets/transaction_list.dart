import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:intl/intl.dart';

import '../models/transcationModel.dart';

class TranscationListWidget extends StatelessWidget {
  final List<TransactionModel> _userTxnList;

  TranscationListWidget(this._userTxnList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTxnList.isEmpty
          ? Column(
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
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    //fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
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
                      DateFormat.yMMMd()
                          .format(_userTxnList[itemIndex].dateTime),
                    ),
                    trailing: null,
                  ),
                );
              },
              itemCount: _userTxnList.length,
              //children: _userTxnList.map((eachTranscation) {}).toList(),
            ),
    );
  }
}
