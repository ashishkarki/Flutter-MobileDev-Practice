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
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '$CURRENT_CURRENCY_SYMBOL${_userTxnList[itemIndex].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _userTxnList[itemIndex].title,
                            style: Theme.of(context).textTheme.title,
                            // TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: ITEM_DESCRIPTION_FONT_SIZE,
                            //   //color: Colors.purpleAccent,
                            // ),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(_userTxnList[itemIndex].dateTime),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ITEM_DESCRIPTION_FONT_SIZE,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: _userTxnList.length,
              //children: _userTxnList.map((eachTranscation) {}).toList(),
            ),
    );
  }
}
