import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:untitled/transaction_list.dart';

const url =
    "http://ec2-3-111-246-190.ap-south-1.compute.amazonaws.com:8080/demo/api/product";
var header = 'bearer 175ed59a-ecdb-4566-9a8a-8be5be3010a2';
List<TransactionList> transactions = [];

Stream<List<TransactionList>> queryData() async* {
  final response = await get(Uri.parse(url), headers: {
    'Authorization' : header
  });
  final Map<String, dynamic> map = json.decode(response.body);
  var jsonData = map["body"] as List;
  var _transaction = jsonData.map((e) => TransactionList.fromJson(e)).toList();
  transactions = _transaction;
  yield _transaction;
}

Future getTotal() async{
  final response = await get(Uri.parse(url), headers: {
    'Authorization' : header
  });
  final Map<String, dynamic> map = json.decode(response.body);
  var jsonData = map["body"] as List;
  transactions = jsonData.map((e) => TransactionList.fromJson(e)).toList();
}

int totalIncome(){
  int _total = 0;
  for(int i=1;i < transactions.length;i++){
    _total += transactions[i].type == 'INCOME'? transactions[i].price:0;
  }
  log(transactions.length.toString());
  return _total;
}

int totalExpense(){
  int _total = 0;
  for(int i=1;i < transactions.length;i++){
    _total += transactions[i].type == 'EXPENSE'? transactions[i].price:0;
  }
  log(transactions.length.toString());
  return _total;
}

Future insertData(TransactionList _trans) async {
  final response = await post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer 175ed59a-ecdb-4566-9a8a-8be5be3010a2'
    },
    body: jsonEncode(
      <String, String>{
        'product_name': _trans.productName, //'TEST5',
        'type': _trans.type, //'EXPENSE',
        'category': _trans.category,
        'price': _trans.price.toString()
      },
    ),
  );
  print(response.body);
  transactions.add(_trans);
  print('Done');
}
