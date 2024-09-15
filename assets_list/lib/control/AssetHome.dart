import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AssetHome extends StatefulWidget {
  const AssetHome({super.key, required this.title});

  final String title;

  @override
  State<AssetHome> createState() => _AssetHomeState();
}

class _AssetHomeState extends State<AssetHome> {

  List<WordPair> _assetList = <WordPair>[];
  TextStyle _biggerFont = const TextStyle(fontSize: 18);

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
        padding: EdgeInsets.all(16),

        itemBuilder: (BuildContext _context, int i) {
          if(i.isOdd) { return Divider(); }
          int index = i ~/ 2;

          if(index >= _assetList.length) {
            _assetList.addAll(generateWordPairs().take(10));
          }

          return _assetRow(_assetList[index]);
        }
    );
  }

  Widget _assetRow(WordPair asset) {

    return ListTile(
      title: Text(
        asset.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}