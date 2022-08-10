import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled/transaction_dataservice.dart';
import 'package:untitled/transaction_model.dart';

import '../../add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionModel> lstTransactions = [];
  double _totalIn = 0;
  num _totalEx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal().whenComplete(() {
      setState(() {
        _totalIn = totalIncome();
        _totalEx = totalExpense();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 3.0,
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'BALANCE',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0, letterSpacing: 5.0),
                      ),
                      Text(
                        (_totalIn.toDouble() - _totalEx.toDouble()).toString(),
                        style: const TextStyle(color: Colors.grey, fontSize: 45.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Income',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    _totalIn.toDouble().toString() + ' \$',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Expense',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    _totalEx.toDouble().toString() + ' \$',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: StreamBuilder<List<TransactionModel>>(
                  stream: queryData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    log('snapshot : ${snapshot.data?.length}');
                    lstTransactions = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: lstTransactions.length,
                      //snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var productName = lstTransactions[index].productName;
                        var category = lstTransactions[index].category;
                        var price = lstTransactions[index].price;
                        var type = lstTransactions[index].type;
                        return Card(
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ],
                            ),
                            title: Text(
                              productName,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            subtitle: Text(
                              category,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            tileColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            trailing: Text(
                              type == 'INCOME' ? '+' + price.toString() : '-' + price.toString(),
                              style: TextStyle(color: type == 'INCOME' ? Colors.green : Colors.red),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  TransactionModel? _transaction = await showDialog<TransactionModel>(
                      context: context,
                      builder: (context) {
                        return const AddPage();
                      });
                  if (_transaction == null) return;
                  await insertData(TransactionModel(
                      _transaction.productName, _transaction.category, _transaction.type, _transaction.price, 0));
                  log('TransactionList on button: ${lstTransactions.length}');
                  //getTotal();
                  setState(() {
                    _totalIn = totalIncome();
                    log('test: $_totalIn');
                  });
                },
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
