import 'package:flutter/material.dart';
import 'model/asset.dart';
import 'model/mock/asset_list.dart';

class AssetListHome extends StatefulWidget {
  const AssetListHome({super.key, required this.title});

  final String title;

  @override
  State<AssetListHome> createState() => _AssetListHomeState();
}

class _AssetListHomeState extends State<AssetListHome> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildAssetList(),
    );
  }

  Widget _buildAssetList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockAssetList.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          int index = i ~/ 2;

          return _buildRow(mockAssetList[index]);
        });
  }

  Widget _buildRow(Asset asset) {
    return ListTile(
      title: Text(
        "${asset.ticker} - ${asset.name}",
        style: _biggerFont,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
                asset.name,
                style: const TextStyle(fontSize: 20),
              )),
          duration: const Duration(milliseconds: 1000),
          width: 180.0,
          padding: const EdgeInsets.all(16.0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
      },
    );
  }
}
