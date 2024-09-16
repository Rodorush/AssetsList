import 'package:assets_list/screens/asset_detail.dart';
import 'package:flutter/material.dart';
import '../model/asset.dart';
import '../model/mock/asset_list.dart';

class AssetListHome extends StatefulWidget {
  const AssetListHome({super.key, required this.title});

  final String title;

  @override
  State<AssetListHome> createState() => _AssetListHomeState();
}

class _AssetListHomeState extends State<AssetListHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildAssetList(),
    );
  }

  Widget _buildAssetList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockAssetList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(mockAssetList[index]);
      },
    );
  }

  Widget _buildCard(Asset asset) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssetDetail(asset: asset),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8), // Rounded rectangle
                ),
                child: Text(
                  asset.ticker,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Preço: R\$ ${asset.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}