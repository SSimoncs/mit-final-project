class TransactionList {
  int id = 0;
  String productName = '';
  String category = '';
  String type = '';
  int price = 0;

  TransactionList.fromJson(Map<String, dynamic> json)
      : productName = json['product_name'],
        category = json['category'],
        type = json['type'],
        price = json['price'],
        id = json['id'];
}
