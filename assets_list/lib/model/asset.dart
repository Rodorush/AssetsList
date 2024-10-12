class Asset {
  final String? id; // Firestore usa id String
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
      'ticker': ticker,
      'name': name,
      'price': price,
      'lastPriceDate': lastPriceDate.toIso8601String(),
    };
  }

  factory Asset.fromFirestore(doc) {
    final data = doc.data()!;
    return Asset(
      id: doc.id,
      ticker: data['ticker'] as String,
      name: data['name'] as String,
      price: data['price'] as double,
      lastPriceDate: DateTime.parse(data['lastPriceDate'] as String),
    );
  }
}
