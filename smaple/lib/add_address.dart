import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _place = '';
  String _city = '';
  String _locality = '';
  String _street = '';
  String _postalCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Add New Address'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Address Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Place',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the place';
                    }
                    return null;
                  },
                  onSaved: (value) => _place = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city';
                    }
                    return null;
                  },
                  onSaved: (value) => _city = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Locality',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the locality';
                    }
                    return null;
                  },
                  onSaved: (value) => _locality = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the street';
                    }
                    return null;
                  },
                  onSaved: (value) => _street = value!,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the postal code';
                    }
                    return null;
                  },
                  onSaved: (value) => _postalCode = value!,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue[700],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Use my location",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )
                    ],
                  ),
                  width: 160,
                  height: 35,
                ),
                // ElevatedButton.icon(

                //   onPressed: () {
                //     // Add logic to pick the current location
                //   },
                //   icon: Icon(Icons.location_on),
                //   label: Text('Pick Current Location'),
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.white,
                //     backgroundColor: Colors.blue[700],
                //     padding: EdgeInsets.symmetric(vertical: 16),
                //   ),
                // ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Add your logic for saving the new address
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save Address',
                      style: TextStyle(
                        fontSize: 18,
                      ),
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
          ),
        ),
      ),
    );
  }
}
