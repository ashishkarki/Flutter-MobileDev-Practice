import 'package:flutter/foundation.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;

  TransactionModel({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.dateTime,
  });
}
