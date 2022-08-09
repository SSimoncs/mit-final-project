import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:untitled/transaction_list.dart';

const url =
    "http://ec2-3-111-246-190.ap-south-1.compute.amazonaws.com:8080/demo/api/product";
List<TransactionList> transactions = [];

Stream<List<TransactionList>> queryData() async* {
  final response = await get(Uri.parse(url), headers: {
    'Authorization': 'bearer 3efea034-a5b9-46a1-980a-c9d1a2523631'
  });
  final Map<String, dynamic> map = json.decode(response.body);
  var jsonData = map["body"] as List;
  var _transaction =
  jsonData.map((e) => TransactionList.fromJson(e)).toList();
  transactions = _transaction;
  yield _transaction;
}

int totalIncome(){
  int _total = 0;
  for(int i=1;i < transactions.length;i++){
    _total += transactions[i].price;
  }
  log('total: $_total');
  return _total;
}

Future insertData(TransactionList _trans) async {

  final response = await post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer 3efea034-a5b9-46a1-980a-c9d1a2523631'
    },
    body: jsonEncode(
      <String, String>{
        'product_name': _trans.productName,//'TEST5',
        'type': _trans.type,//'EXPENSE',
        'category': _trans.category,
        'price': _trans.price.toString()
      },
    ),
  );
  print(response.body);
  await queryData();
  print('Done');
}

String getData (String _txt){
  return _txt;
}