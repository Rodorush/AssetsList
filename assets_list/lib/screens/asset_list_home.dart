import 'package:flutter/material.dart';
import '../model/asset.dart';
import '../util/firestore_helper.dart';
import 'asset_detail.dart';

class AssetListHome extends StatefulWidget {
  const AssetListHome({super.key, required this.title});

  final String title;

  @override
  State<AssetListHome> createState() => _AssetListHomeState();
}

class _AssetListHomeState extends State<AssetListHome> {
  final FirestoreHelper _firestoreHelper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _navigateToDetail(context, null);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Asset>>(
        stream: _firestoreHelper.streamAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum ativo disponível"));
          }

          final assets = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: assets.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(assets[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(Asset asset) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          _navigateToDetail(context, asset);
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
                  borderRadius: BorderRadius.circular(8),
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

  void _navigateToDetail(BuildContext context, Asset? asset) async {
    final bool shouldReload = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssetDetail(asset: asset),
      ),
    );
    if (shouldReload == true) {
      setState(() {}); // Firestore StreamBuilder já cuida do recarregamento
    }
  }
}