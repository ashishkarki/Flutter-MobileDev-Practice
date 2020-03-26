import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/transcationModel.dart';
import 'transaction_item.dart';

class TranscationListWidget extends StatelessWidget {
  final List<TransactionModel> _userTxnList;
  final Function _deleteTransaction;

  const TranscationListWidget(
    this._userTxnList,
    this._deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    print('build() TranscationListWidget');
    final themeCtx = Theme.of(context);
    final mediaQryCtx = MediaQuery.of(context);

    return _userTxnList.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions yet. Add Now.',
                  style: themeCtx.textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // to stop the image from overflowing
                  height: constraints.maxHeight * TX_LIST_IMAGE_PERCENT,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    //fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            // Note: ListView takes up all the availble space
            itemBuilder: (buildContext, itemIndex) {
              return TransactionItemWidget(
                  userTransaction: _userTxnList[itemIndex],
                  themeCtx: themeCtx,
                  mediaQryCtx: mediaQryCtx,
                  deleteTransaction: _deleteTransaction);
            },
            itemCount: _userTxnList.length,
            //children: _userTxnList.map((eachTranscation) {}).toList(),
          );
  }
}
