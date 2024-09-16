import 'package:flutter/material.dart';
import '../model/asset.dart';

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
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${asset.ticker} - ${asset.name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(
                        "Preço: \$${asset.price.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        "Data do último preço: ${asset.lastPriceDate.toLocal()}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Example action for buying the asset
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Alterar"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Example action for selling the asset
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Excluir"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}