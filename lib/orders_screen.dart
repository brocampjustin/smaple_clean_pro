import 'package:flutter/material.dart';
import 'package:smaple/order_status.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {'id': '1234', 'status': 'In Progress', 'date': '2024-08-01'},
    {'id': '5678', 'status': 'Completed', 'date': '2024-07-28'},
    {'id': '9012', 'status': 'Scheduled', 'date': '2024-08-05'},
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('My Orders'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child:
                            Icon(Icons.receipt_long, color: Colors.blue[700]),
                      ),
                      title: Text('Order #${order['id']}'),
                      subtitle: Text('${order['status']} - ${order['date']}'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Add order details navigation logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderStatusScreen(
                              orderId: '12345',
                              orderDate: DateTime.now(),
                              items: [
                                {
                                  'name': 'T-Shirt',
                                  'price': 2.50,
                                  'quantity': 2
                                },
                                {'name': 'Pants', 'price': 3.00, 'quantity': 1},
                              ],
                              total: 8.00,
                              status: 'In Progress',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
