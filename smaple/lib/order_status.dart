import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatusScreen extends StatelessWidget {
  final String orderId;
  final DateTime orderDate;
  final List<Map<String, dynamic>> items;
  final double total;
  final String status;

  OrderStatusScreen({
    required this.orderId,
    required this.orderDate,
    required this.items,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOrderInfo(context),
            _buildOrderStatus(context),
            _buildOrderItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #$orderId',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Placed on ${DateFormat('MMM d, yyyy').format(orderDate)}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 8),
          Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {
        'title': 'Order Placed',
        'subtitle': 'We\'ve received your order',
        'icon': Icons.assignment_turned_in,
        'date': orderDate,
      },
      {
        'title': 'Order Confirmed',
        'subtitle': 'Your order has been confirmed',
        'icon': Icons.check_circle,
        'date': orderDate.add(Duration(hours: 1)),
      },
      {
        'title': 'In Progress',
        'subtitle': 'We\'re working on your laundry',
        'icon': Icons.local_laundry_service,
        'date': orderDate.add(Duration(hours: 3)),
      },
      {
        'title': 'Ready for Pickup',
        'subtitle': 'Your clean clothes are ready',
        'icon': Icons.shopping_bag,
        'date': orderDate.add(Duration(hours: 24)),
      },
      {
        'title': 'Delivered',
        'subtitle': 'Your order has been delivered',
        'icon': Icons.home,
        'date': orderDate.add(Duration(hours: 26)),
      },
    ];

    int currentStep = steps.indexWhere((step) => step['title'] == status);
    if (currentStep == -1) currentStep = 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Order Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          ...steps.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, dynamic> step = entry.value;
            bool isActive = idx <= currentStep;
            bool isLast = idx == steps.length - 1;

            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              isFirst: idx == 0,
              isLast: isLast,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: isActive ? Colors.blue[700]! : Colors.grey[300]!,
                iconStyle: IconStyle(
                  color: isActive ? Colors.white : Colors.grey[500]!,
                  iconData: step['icon'],
                ),
              ),
              beforeLineStyle: LineStyle(
                color: isActive ? Colors.blue[700]! : Colors.grey[300]!,
              ),
              endChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.black : Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      step['subtitle'],
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? Colors.grey[600] : Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      DateFormat('MMM d, h:mm a').format(step['date']),
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.blue[700] : Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.cleaning_services, color: Colors.blue[700]),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Quantity: ${item['quantity']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}