import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Tables',
      'icon': Icons.table_bar,
      'stock': 12,
    },
    {
      'name': 'Chairs',
      'icon': Icons.chair,
      'stock': 700,
    },
    {
      'name': 'Tents',
      'icon': Icons.holiday_village,
      'stock': 10,
    },
  ];

  void _editStock(int index) {
    final TextEditingController controller = TextEditingController(
      text: _items[index]['stock'].toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Stock for ${_items[index]['name']}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _items[index]['stock'] = int.tryParse(controller.text) ?? _items[index]['stock'];
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return StockItemCard(
              item: _items[index],
              onEdit: () => _editStock(index),
            );
          },
        ),
      ),
    );
  }
}

class StockItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onEdit;

  const StockItemCard({super.key, required this.item, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(item['icon'], size: 40, color: Colors.blue),
        title: Text(
          item['name'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Stock: ${item['stock']}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
