import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      //return = pass
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Titre'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              //onChanged: (val) {
              //titleInput = val;
              //},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Montant'),
              //onChanged: (val) => amountInput = val,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                                      child: Text(
                      _selectedDate == null
                          ? 'Pas de date selectionnée'
                          : 'Date selectionnée : ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choisir date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Ajouter une transaction'),
              color: Theme.of(context).primaryColor,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}