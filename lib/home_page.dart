import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/transaction.dart';
import 'package:untitled/transaction_list.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionList> lstTransactions = [];

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
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            letterSpacing: 5.0),
                      ),
                      const Text(
                        '\$ 2000',
                        style: TextStyle(color: Colors.grey, fontSize: 45.0),
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
                                children: const [
                                  Text(
                                    'Income',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '\$100',
                                    style: TextStyle(color: Colors.grey),
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
                                children: const [
                                  Text(
                                    'Expense',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '\$50',
                                    style: TextStyle(color: Colors.grey),
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
                child: StreamBuilder<List<TransactionList>>(
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            trailing: const Text(
                              '\$100',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    InsertData();
                  });
                  // queryData().listen((value) {
                  //   print('1st: $value');
                  // });
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return const AddPage();
                  //     });
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
