import 'package:app/services/problem_type.dart';
import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/services/ticket_status.dart';
import 'package:app/widgets/problemTypeDropDown.dart';
import 'package:app/widgets/take_picture_button.dart';
import 'package:app/widgets/ticketStatusDropDown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class TicketScreen extends StatefulWidget {
  TicketScreen({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool isRefreshing = false;

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    setState(() {
      isRefreshing = false;
    });
  }

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
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Vehicle ' +
                      widget.ticket.licencePlate +
                      ' for ' +
                      widget.ticket.name,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            TakePictureButton(ticket: widget.ticket),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 12, 136, 136)),
                ),
                onPressed: () {
                  print(widget.ticket.name +
                      "'s ticket: trying to set GPS Location."); //DEBUG
                  //Logic to open the device camera and capture an image goes here.
                },
                child: const Text(
                  'Set GPS Location',
                  style: TextStyle(color: Colors.amberAccent),
                )),
            TicketStatusDropDown(ticket: widget.ticket),
            ProblemTypeDropDown(ticket: widget.ticket)
          ],
        ),
      ),
    );
  }
}
