import 'package:app/screens/ticket.dart';
import 'package:app/widgets/pick_up_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  List<Map<String, dynamic>> cars = [];
  bool isRefreshing = false;

  Future<void> getCars() async {
    final response = await http.get(Uri.parse('${Config.domain.scheme}://${Config.domain.host}/tickets'));
    if (response.statusCode == 200) {
      setState(() {
        cars = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle errors here
      print('Failed to fetch tickets: ${response.statusCode}');
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await getCars();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCars();
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
          icon: Icon(Icons.arrow_back), // You can use any icon you prefer
          onPressed: () {
            // Add your back button logic here
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'PickUp Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return PickUpListTileWidget(ticket: car);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
