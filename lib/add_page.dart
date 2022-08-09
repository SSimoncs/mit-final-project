import 'package:flutter/material.dart';
import 'package:untitled/transaction.dart';
import 'package:untitled/transaction_list.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var _isSwitch = false;
  late TextEditingController txtProductName;
  late TextEditingController txtCategory;
  late TextEditingController txtPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtProductName = TextEditingController();
    txtCategory = TextEditingController();
    txtPrice = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtProductName.dispose();
    txtCategory.dispose();
    txtPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            //contentPadding: EdgeInsets.zero,
            buttonPadding: const EdgeInsets.fromLTRB(0, 0, 10.0, 20.0),
            backgroundColor: Colors.black,
            title: const Text(
              'NEW TRANSACTION',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            content: SizedBox(
              height: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Expense',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.red,
                        activeColor: Colors.grey,
                        activeTrackColor: Colors.green,
                        value: _isSwitch,
                        onChanged: (value) {
                          setState(() {
                            _isSwitch = !_isSwitch;
                          });
                          print(_isSwitch);
                        },
                      ),
                      const Text(
                        'Income',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtProductName,
                    decoration: const InputDecoration(
                      focusColor: Colors.red,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 3, color: Colors.grey),
                      ),
                      hintText: 'ProductName',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtCategory,
                    decoration: const InputDecoration(
                      focusColor: Colors.red,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 3, color: Colors.grey),
                      ),
                      hintText: 'Category',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtPrice,
                    decoration: const InputDecoration(
                      focusColor: Colors.red,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 3, color: Colors.grey),
                      ),
                      hintText: 'Price',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                    TransactionList(txtProductName.text, txtCategory.text,
                        _isSwitch == true?'INCOME':'EXPENSE', int.parse(txtPrice.text), 0),
                  );
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }
}
