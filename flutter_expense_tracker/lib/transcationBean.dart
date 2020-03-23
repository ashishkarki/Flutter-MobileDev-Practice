import 'package:flutter/foundation.dart';

class TransactionBean {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;

  TransactionBean({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.dateTime,
  });
}
