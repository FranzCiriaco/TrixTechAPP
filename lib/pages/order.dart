import 'package:flutter/material.dart';
import 'order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static List<Map<String, dynamic>> orders = [];

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _tableController = TextEditingController();
  final _chairController = TextEditingController();
  final _tentController = TextEditingController();

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // Add the order to the OrderPage
      OrderPage.orders.add({
        'name': _nameController.text,
        'location': _locationController.text,
        'phone': _phoneController.text,
        'tables': int.parse(_tableController.text),
        'chairs': int.parse(_chairController.text),
        'tents': int.parse(_tentController.text),
      });

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Order Placed'),
          content: Text(
              'Name: ${_nameController.text}\nLocation: ${_locationController.text}\nPhone: ${_phoneController.text}\n\nTables: ${_tableController.text}\nChairs: ${_chairController.text}\nTents: ${_tentController.text}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );

      // Clear the form after submission
      _formKey.currentState!.reset();
      _nameController.clear();
      _locationController.clear();
      _phoneController.clear();
      _tableController.clear();
      _chairController.clear();
      _tentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Full Name', _nameController),
                const SizedBox(height: 16),
                _buildTextField('Location', _locationController),
                const SizedBox(height: 16),
                _buildTextField('Phone Number', _phoneController, type: TextInputType.phone),
                const SizedBox(height: 16),
                _buildQuantityField('Tables', _tableController),
                const SizedBox(height: 16),
                _buildQuantityField('Chairs', _chairController),
                const SizedBox(height: 16),
                _buildQuantityField('Tents', _tentController),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitOrder,
                    child: const Text('Place Order'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildQuantityField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter quantity';
        }
        if (int.tryParse(value) == null) {
          return 'Enter a valid number';
        }
        return null;
      },
    );
  }
}
