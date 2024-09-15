import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AssetHome extends StatefulWidget {
  const AssetHome({super.key, required this.title});

  final String title;

  @override
  State<AssetHome> createState() => _AssetHomeState();
}

class _AssetHomeState extends State<AssetHome> {
  final List<WordPair> _assetList = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

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
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          int index = i ~/ 2;

          if (index >= _assetList.length) {
            _assetList.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_assetList[index]);
        });
  }

  Widget _buildRow(WordPair asset) {
    return ListTile(
      title: Text(
        asset.asPascalCase,
        style: _biggerFont,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
            asset.asPascalCase,
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
