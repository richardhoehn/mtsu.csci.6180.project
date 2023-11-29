import 'dart:convert';
import 'package:app/services/geo_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;
import 'package:app/util/config.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropOffScreen extends StatefulWidget {
  const DropOffScreen({super.key});

  @override
  State<DropOffScreen> createState() => _DropOffScreenState();
}

class _DropOffScreenState extends State<DropOffScreen> {
  final dio = Dio();
  final TextEditingController licencePlateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Position? position;
  //GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    getLocation();
    //Config.domain.host + "/cars";
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

    final GeoLocation location = GeoLocation(lng: position!.longitude, lat: position!.latitude);

    Response response = await dio.post('${Config.domain.scheme}://${Config.domain.host}/tickets', data: {
      'licencePlate': licencePlate,
      'name': name,
      'geoLocation': location.toJson(),
    });

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Image.asset(
          Config.images.squareWhiteLogo,
          fit: BoxFit.contain,
          height: 36,
        ),
        toolbarHeight: 55,
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
