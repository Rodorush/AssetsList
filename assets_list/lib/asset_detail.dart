import 'package:flutter/material.dart';
import 'model/asset.dart';

class AssetDetail extends StatelessWidget {
  final Asset asset;

  const AssetDetail({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${asset.ticker} - ${asset.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Código: ${asset.ticker}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Nome: ${asset.name}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Preço: \$${asset.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Data do último preço: ${asset.lastPriceDate.toLocal()}", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}