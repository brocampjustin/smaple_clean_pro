import 'package:flutter/material.dart';
import 'package:smaple/add_address.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double total;
  final List<String> addresses;

  const CheckoutScreen({
    Key? key,
    required this.cartItems,
    required this.total,
    required this.addresses,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedAddress = '';
  String _name = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    if (widget.addresses.isNotEmpty) {
      _selectedAddress = widget.addresses[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Checkout'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildOrderSummary(),
                SizedBox(height: 24),
                Text(
                  'Delivery Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildDeliveryDetailsForm(),
                SizedBox(height: 24),
                _buildTotalAndConfirm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ...widget.cartItems.map((item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['name']} x${item['quantity']}'),
                      Text(
                          '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${widget.total.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryDetailsForm() {
    return Column(
      children: [
        TextFormField(
          controller: TextEditingController(text: "John"),
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          onSaved: (value) => _name = value!,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: TextEditingController(text: "9928384329"),
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
          onSaved: (value) => _phone = value!,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select Address',
            border: OutlineInputBorder(),
          ),
          value: _selectedAddress.isNotEmpty ? _selectedAddress : null,
          items: widget.addresses
              .map((address) => DropdownMenuItem(
                    value: address,
                    child: Text(address),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedAddress = value!;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an address';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Navigate to add address screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAddressScreen(),
              ),
            );
          },
          child: Text('Add New Address'),
        ),
      ],
    );
  }

  Widget _buildTotalAndConfirm() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${widget.total.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700]),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitOrder,
            child: Text(
              'Confirm Order',
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
    );
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would typically send the order to your backend
      print('Order submitted:');
      print('Name: $_name');
      print('Phone: $_phone');
      print('Address: $_selectedAddress');
      print('Items: ${widget.cartItems}');
      print('Total: \$${widget.total.toStringAsFixed(2)}');

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Order Confirmed'),
          content: Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate back to the home screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

// class AddAddressScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Address'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'New Address',
//                 border: OutlineInputBorder(),
//               ),
//               // Add your logic for saving the new address
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Add your logic for saving the new address and navigating back
//               },
//               child: Text('Save Address'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
