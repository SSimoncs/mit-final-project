import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var _isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(
        //contentPadding: EdgeInsets.zero,
        buttonPadding: const EdgeInsets.fromLTRB(0, 0, 10.0, 20.0),
        backgroundColor: Colors.black,
        title: const Text(
          'NEW TRANSACTION',
          style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
        ),
        content: SizedBox(
          height: 200,
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
                    },
                  ),
                  const Text(
                    'Income',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const TextField(
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 3, color: Colors.grey),
                  ),
                  hintText: 'Amount',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),),
              ),
              const TextField(
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 3, color: Colors.grey),
                  ),
                  hintText: 'Remark',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(onPressed: (){

          }, child: const Text('Cancel'),),
          OutlinedButton(onPressed: (){}, child: const Text('Add'),),
        ],
      ),
    );
  }
}