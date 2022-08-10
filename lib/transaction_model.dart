class TransactionModel {
   final int id ;
   final String productName ;
   final String category ;
   final String type ;
   final double price;

   TransactionModel(this.productName,this.category,this.type,this.price, this.id);

  TransactionModel.fromJson(Map<String,dynamic> json)
   :  productName=json['product_name'],
      category=json['category'],
      type=json['type'],
      price=json['price'].toDouble(),
      id=json['id'];
}