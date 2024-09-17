class Asset {
  final int? id;
  final String ticker;
  final String name;
  final double price;
  final DateTime lastPriceDate;

  Asset({
    this.id,
    required this.ticker,
    required this.name,
    required this.price,
    required this.lastPriceDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ticker': ticker,
      'name': name,
      'price': price,
      'lastPriceDate': lastPriceDate.toIso8601String(),
    };
  }

 factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] as int?,
      ticker: map['ticker'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      lastPriceDate: DateTime.parse(map['lastPriceDate'] as String),
    );
  }
}