import 'package:app/services/ticket.dart';
import 'package:app/widgets/problem_type_row.dart';
import 'package:app/widgets/take_picture_button.dart';
import 'package:app/widgets/ticket_image.dart';
import 'package:app/widgets/ticket_status_row.dart';
import 'package:flutter/material.dart';
import 'package:app/util/config.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key, required this.ticket});
  final Ticket ticket;

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
                  'Vehicle ' + widget.ticket.licencePlate + ' for ' + widget.ticket.name,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TakePictureButton(ticket: widget.ticket),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 12, 136, 136)),
                    ),
                    onPressed: () {
                      print(widget.ticket.name + "'s ticket: trying to set GPS Location."); //DEBUG
                      //Logic to open the device camera and capture an image goes here.
                    },
                    child: const Text(
                      'Set GPS Location',
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: TicketImageWidget(ticket: widget.ticket),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TicketStatusRow(ticket: widget.ticket),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ProblemTypeRow(ticket: widget.ticket),
            ),
          ],
        ),
      ),
    );
  }
}
