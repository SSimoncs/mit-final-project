import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:untitled/transaction_model.dart';

import 'helper/Setting.dart';

final token = Setting.newInstance()?.token;

const url = "http://ec2-3-111-246-190.ap-south-1.compute.amazonaws.com:8080/demo/api/product";
var header = 'bearer $token';
List<TransactionModel> transactions = [];

Stream<List<TransactionModel>> queryData() async* {
  final response = await get(Uri.parse(url), headers: {'Authorization': header});
  final Map<String, dynamic> map = json.decode(response.body);
  var jsonData = map["body"] as List;
  var _transaction = jsonData.map((e) => TransactionModel.fromJson(e)).toList();
  transactions = _transaction;
  yield _transaction;
}

Future getTotal() async {
  final response = await get(Uri.parse(url), headers: {'Authorization': header});
  final Map<String, dynamic> map = json.decode(response.body);
  var jsonData = map["body"] as List;
  transactions = jsonData.map((e) => TransactionModel.fromJson(e)).toList();
}

double totalIncome() {
  double _total = 0;
  for (int i = 1; i < transactions.length; i++) {
    _total += transactions[i].type == 'INCOME' ? transactions[i].price : 0;
  }
  log(transactions.length.toString());
  return _total;
}

double totalExpense() {
  double _total = 0;
  for (int i = 1; i < transactions.length; i++) {
    _total += transactions[i].type == 'EXPENSE' ? transactions[i].price : 0;
  }
  log(transactions.length.toString());
  return _total;
}

Future insertData(TransactionModel _trans) async {
  final response = await post(
    Uri.parse(url),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'bearer $token'},
    body: jsonEncode(
      <String, String>{
        'product_name': _trans.productName, //'TEST5',
        'type': _trans.type, //'EXPENSE',
        'category': _trans.category,
        'price': _trans.price.toString()
      },
    ),
  );
  if (json.decode(response.body)["resultMessage"] == "SUCCESS") {
    transactions.add(_trans);
  }
}
