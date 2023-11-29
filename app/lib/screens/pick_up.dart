import 'package:app/screens/ticket.dart';
import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/widgets/pick_up_list_tile.dart';
import 'package:dio/dio.dart';
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
  Dio dio = DioClient().dio;
  List<Ticket> tickets = List.empty(growable: true);
  bool isRefreshing = false;


  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    tickets = await DioClient().getAllTickets();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
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
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    return PickUpListTileWidget(ticket: tickets[index]);
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
