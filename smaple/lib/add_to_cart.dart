import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({Key? key}) : super(key: key);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final List<String> _categories = ['All', 'Women', 'Men', 'Children', 'Other'];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final Map<String, List<Map<String, dynamic>>> _items = {
    'Women': [
      {'name': 'Dress', 'price': 5.00, 'quantity': 0},
      {'name': 'Blouse', 'price': 3.50, 'quantity': 0},
      {'name': 'Skirt', 'price': 4.00, 'quantity': 0},
    ],
    'Men': [
      {'name': 'T-Shirt', 'price': 2.50, 'quantity': 0},
      {'name': 'Pants', 'price': 3.00, 'quantity': 0},
      {'name': 'Jacket', 'price': 6.00, 'quantity': 0},
    ],
    'Children': [
      {'name': 'Onesie', 'price': 2.00, 'quantity': 0},
      {'name': 'Kids T-Shirt', 'price': 2.00, 'quantity': 0},
      {'name': 'Kids Pants', 'price': 2.50, 'quantity': 0},
    ],
    'Other': [
      {'name': 'Bedsheet', 'price': 4.50, 'quantity': 0},
      {'name': 'Towel', 'price': 2.00, 'quantity': 0},
      {'name': 'Curtain', 'price': 7.00, 'quantity': 0},
    ],
  };

  List<Map<String, dynamic>> get _filteredItems {
    List<Map<String, dynamic>> result = [];
    if (_selectedCategory == 'All') {
      _items.values.forEach(result.addAll);
    } else {
      result = _items[_selectedCategory] ?? [];
    }
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((item) =>
              item['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return result;
  }

  double get _total => _filteredItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Add to Cart'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${item['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: item['quantity'] > 0
                                  ? () => _updateQuantity(item, -1)
                                  : null,
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: TextEditingController(
                                    text: item['quantity'].toString()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) => _updateQuantity(
                                    item, int.tryParse(value) ?? 0,
                                    setDirectly: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _updateQuantity(item, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildTotalAndAddToCart(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(_categories[index]),
              selected: _selectedCategory == _categories[index],
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = _categories[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search items...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAndAddToCart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _total > 0 ? _addToCart : null,
              child: Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(Map<String, dynamic> item, int change,
      {bool setDirectly = false}) {
    setState(() {
      if (setDirectly) {
        item['quantity'] = change.clamp(0, 99);
      } else {
        item['quantity'] = (item['quantity'] + change).clamp(0, 99);
      }
    });
  }

  void _addToCart() {
    final selectedItems =
        _filteredItems.where((item) => item['quantity'] > 0).toList();
    print('Added to cart: $selectedItems');
    print('Total: \$${_total.toStringAsFixed(2)}');
    Navigator.pop(context);
  }
}
