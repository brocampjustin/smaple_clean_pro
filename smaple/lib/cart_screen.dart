import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smaple/checkout_page.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // This would typically come from a state management solution
  List<Map<String, dynamic>> cartItems = [
    {'name': 'T-Shirt', 'price': 2.50, 'quantity': 2},
    {'name': 'Pants', 'price': 3.00, 'quantity': 1},
    {'name': 'Dress', 'price': 5.00, 'quantity': 1},
  ];

  double get total => cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Cart'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
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
                                '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
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
                              onPressed: () => _updateQuantity(index, -1),
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: TextEditingController(
                                    text: item['quantity'].toString()),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  int? newQuantity = int.tryParse(value);
                                  if (newQuantity != null) {
                                    _updateQuantity(index, newQuantity,
                                        setDirectly: true);
                                  }
                                },
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
                              onPressed: () => _updateQuantity(index, 1),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildTotalAndCheckout(),
        ],
      ),
    );
  }

  Widget _buildTotalAndCheckout() {
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
                '\$${total.toStringAsFixed(2)}',
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
              onPressed: cartItems.isNotEmpty ? _proceedToCheckout : null,
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
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

  void _updateQuantity(int index, int change, {bool setDirectly = false}) {
    setState(() {
      if (setDirectly) {
        cartItems[index]['quantity'] = change.clamp(0, 99);
      } else {
        cartItems[index]['quantity'] =
            (cartItems[index]['quantity'] + change).clamp(0, 99);
      }
      if (cartItems[index]['quantity'] == 0) {
        _removeItem(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _proceedToCheckout() {
    final List<String> addresses = [
      '123 Main St, Springfield, USA',
      '456 Elm St, Springfield, USA',
      '789 Maple St, Springfield, USA',
    ];
    // Implement checkout logic here
    print('Proceeding to checkout with items: $cartItems');
    print('Total: \$${total.toStringAsFixed(2)}');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CheckoutScreen(
          cartItems: cartItems, total: total, addresses: addresses),
    ));
  }
}
