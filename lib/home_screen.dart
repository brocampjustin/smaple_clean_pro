import 'package:flutter/material.dart';
import 'package:smaple/add_to_cart.dart';
import 'package:smaple/cart_screen.dart';
import 'package:smaple/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    CartScreen(),
    OrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCartScreen()),
                );
              },
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue[700],
            )
          : null,
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(),
                    SizedBox(height: 24),
                    _buildServiceCategories(),
                    SizedBox(height: 24),
                    _buildRecentOrders(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ... (keep the rest of the methods from the previous HomeScreen)
}

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Cart Screen'),
//     );
//   }
// }

// class OrdersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Orders Screen'),
//     );
//   }
// }

Widget _buildAppBar() {
  return Container(
    padding: EdgeInsets.all(16),
    color: Colors.blue[700],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Clean Pro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Colors.blue[700]),
        ),
      ],
    ),
  );
}

Widget _buildGreeting() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hello, John!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'What would you like to clean today?',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}

Widget _buildServiceCategories() {
  final categories = [
    {'name': 'Wash & Fold', 'icon': Icons.local_laundry_service},
    {'name': 'Dry Cleaning', 'icon': Icons.dry_cleaning},
    {'name': 'Ironing', 'icon': Icons.iron},
    {'name': 'Other', 'icon': Icons.construction},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Our Services',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddToCartScreen(),
                ));
                // Add category selection logic here
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categories[index]['icon'] as IconData,
                    size: 40,
                    color: Colors.blue[700],
                  ),
                  SizedBox(height: 8),
                  Text(
                    categories[index]['name'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget _buildRecentOrders() {
  final recentOrders = [
    {'id': '1234', 'status': 'In Progress', 'date': '2024-08-01'},
    {'id': '5678', 'status': 'Completed', 'date': '2024-07-28'},
    {'id': '9012', 'status': 'Scheduled', 'date': '2024-08-05'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Orders',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 16),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recentOrders.length,
        itemBuilder: (context, index) {
          final order = recentOrders[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.receipt_long, color: Colors.blue[700]),
              ),
              title: Text('Order #${order['id']}'),
              subtitle: Text('${order['status']} - ${order['date']}'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Add order details navigation logic here
              },
            ),
          );
        },
      ),
    ],
  );
}
