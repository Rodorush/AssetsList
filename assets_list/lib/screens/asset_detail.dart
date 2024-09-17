import 'package:flutter/material.dart';
import '../model/asset.dart';
import '../util/database_helper.dart';

class AssetDetail extends StatefulWidget {
  final Asset? asset;

  const AssetDetail({super.key, this.asset});

  @override
  State<AssetDetail> createState() => _AssetDetailState();
}

class _AssetDetailState extends State<AssetDetail> {
  final _tickerController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.asset != null) {
      _tickerController.text = widget.asset!.ticker;
      _nameController.text = widget.asset!.name;
      _priceController.text = widget.asset!.price.toString();
      _selectedDate = widget.asset!.lastPriceDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.asset == null
            ? 'Novo Ativo'
            : "${widget.asset!.ticker} - ${widget.asset!.name}"),
      ),
      body: SingleChildScrollView(
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
                    TextField(
                      controller: _tickerController,
                      decoration: const InputDecoration(
                        labelText: "Código",
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.attach_money),
                      title: TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Preço",
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today),
                      title: GestureDetector(
                        onTap: _selectDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: "Data do último preço",
                            labelStyle: TextStyle(fontSize: 18),
                            border: InputBorder.none,
                          ),
                          child: Text(
                            _formatDate(_selectedDate),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
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
                  onPressed: _saveAsset,
                  icon: const Icon(Icons.edit),
                  label: const Text("Salvar"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _deleteAsset,
                  icon: const Icon(Icons.delete),
                  label: const Text("Excluir"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveAsset() async {
    final String ticker = _tickerController.text;
    final String name = _nameController.text;
    final double price = double.tryParse(_priceController.text) ?? 0;

    if (ticker.isNotEmpty && name.isNotEmpty && price > 0) {
      if (widget.asset == null) {
        final newAsset = Asset(
          ticker: ticker,
          name: name,
          price: price,
          lastPriceDate: _selectedDate,
        );
        await _dbHelper.insertAsset(newAsset);
      } else {
        final updatedAsset = Asset(
          id: widget.asset!.id,
          ticker: ticker,
          name: name,
          price: price,
          lastPriceDate: _selectedDate,
        );
        await _dbHelper.updateAsset(updatedAsset);
      }
      Navigator.pop(context, true);
    }
  }

  void _deleteAsset() async {
    if (widget.asset != null) {
      await _dbHelper.deleteAsset(widget.asset!.id!);
      Navigator.pop(context, true);
    }
  }
}
