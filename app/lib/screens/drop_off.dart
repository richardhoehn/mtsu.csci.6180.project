import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropOffScreen extends StatefulWidget {
  const DropOffScreen({super.key});

  @override
  State<DropOffScreen> createState() => _DropOffScreenState();
}

class _DropOffScreenState extends State<DropOffScreen> {
  final TextEditingController licencePlateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Position? position;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition();
      setState(() {
        print('Update Position');
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> addCar() async {
    final String licencePlate = licencePlateController.text;
    final String name = nameController.text;
    final double lat = position == null ? 0 : position!.latitude;
    final double lng = position == null ? 0 : position!.longitude;

    final Map<String, dynamic> data = {
      'licencePlate': licencePlate,
      'name': name,
      'lng': lng,
      'lat': lat,
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/cars'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Car added successfully, handle the response as needed.
    } else {
      // Handle errors here
      print('Failed to add car: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Valet Buddy')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // You can use any icon you prefer
          onPressed: () {
            // Add your back button logic here
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Drop Off Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            TextField(
              controller: licencePlateController,
              decoration: const InputDecoration(labelText: 'Licence Plate'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            position == null ? Text('Searching Poistion') : Text('Found Position'),
            // Display the map
            ElevatedButton(
              onPressed: addCar,
              child: const Text('Add Car'),
            ),
          ],
        ),
      ),
    );
  }
}
