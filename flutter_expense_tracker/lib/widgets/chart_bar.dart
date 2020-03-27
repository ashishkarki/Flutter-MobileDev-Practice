import 'package:flutter/material.dart';

import '../constants.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentOfTotal;

  const ChartBarWidget(
      this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    print('build() ChartBarWidget');
    final themeCtx = Theme.of(context);

    return LayoutBuilder(
      builder: (ctx, constraints) {
        // constraints that is applied to this widget: chartbarwidget
        final maxHght = constraints.maxHeight;
        return Column(
          children: <Widget>[
            Container(
              height: maxHght * 0.15,
              child: FittedBox(
                child: Text(
                    '$CURRENT_CURRENCY_SYMBOL${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: maxHght * 0.05,
            ),
            Container(
              height: maxHght * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: themeCtx.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: maxHght * 0.05,
            ),
            Container(
              height: maxHght * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
