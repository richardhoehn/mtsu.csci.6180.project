import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class TicketScreen extends StatefulWidget {
  TicketScreen({super.key});


  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    super.initState();
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
                  'Ticket Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
