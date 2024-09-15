class Asset {
  final String ticker;
  final String name;
  final double price;
  final DateTime lastPriceDate;

  Asset({
    required this.ticker,
    required this.name,
    required this.price,
    required this.lastPriceDate,
  });
}