import 'package:flutter/foundation.dart'; //for @required

class Transaction {
  //setting properties
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //We add a constructor so that we can use the transaction anywhere
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date});
}



