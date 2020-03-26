import 'package:flutter/material.dart';

import '../models/transcationModel.dart';
import '../constants.dart';
import 'chart.dart';
import 'transaction_list.dart';

class MainBodyWidget extends StatefulWidget {
  final PreferredSizeWidget myAppBar;
  final List<TransactionModel> _userTxnList;

  MainBodyWidget(this.myAppBar, this._userTxnList) {
    print('Constructor MainBodyWidget');
  }

  @override
  _MainBodyWidgetState createState() => _MainBodyWidgetState();
}

class _MainBodyWidgetState extends State<MainBodyWidget> {
  var _showChart = false;

  List<TransactionModel> get _recentTransactions {
    return widget._userTxnList.where((transaction) {
      return transaction.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String deletedItemId) {
    setState(() {
      widget._userTxnList.removeWhere((tx) => tx.id == deletedItemId);
    });
  }

  Widget _landscapeContentBuilder(ThemeData themeCtx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show Chart',
          style: themeCtx.textTheme.title,
        ),
        Switch.adaptive(
            // makes this switch adapt based on ios or android
            value: _showChart,
            onChanged: (newVal) {
              setState(() {
                _showChart = newVal;
              });
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build() _MainBodyWidgetState');
    final themeCtx = Theme.of(context);
    final mediaQryCtx = MediaQuery.of(context);
    final isLandscapeMode = mediaQryCtx.orientation == Orientation.landscape;

    final appBodyHeightOnly = (mediaQryCtx.size.height -
        widget.myAppBar.preferredSize.height -
        mediaQryCtx.padding.top);
    // final curScaleFactor =
    //     mediaQryCtx.textScaleFactor;
    final chartWidgetExpression = Container(
      height: appBodyHeightOnly * 0.3,
      child: ChartWidget(_recentTransactions),
    );
    final txWidgetExpression = Container(
      height: appBodyHeightOnly * TX_LIST_HEIGHT_PERCENT,
      child: TranscationListWidget(widget._userTxnList, _deleteTransaction),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (isLandscapeMode) ...[
          _landscapeContentBuilder(themeCtx),
          _showChart ? chartWidgetExpression : txWidgetExpression,
        ],
        if (!isLandscapeMode) ...[chartWidgetExpression, txWidgetExpression],
        //if (!isLandscapeMode) txWidgetExpression,
        // if (isLandscapeMode)
        //   _showChart ? chartWidgetExpression : txWidgetExpression,
      ],
    );
  }
}
