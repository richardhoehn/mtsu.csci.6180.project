import 'package:app/services/ticket.dart';
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
  List<Map<String, dynamic>> ticketStatuses = [];
  List<Map<String, dynamic>> problemTypes = [];
  bool isRefreshing = false;
  String dropdownvalueStatuses =
      '2'; //Default value that is changed in initState()
  String dropdownvalueProblems =
      '1'; //Default value that is changed in initState()

  Future<void> getTicketStatuses() async {
    final response = await http.get(Uri.parse(
        '${Config.domain.scheme}://${Config.domain.host}/ticketStatuses'));
    if (response.statusCode == 200) {
      setState(() {
        ticketStatuses =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        dropdownvalueStatuses =
            '1'; //widget.ticket['ticketStatusId'].toString();
      });
      print('Status default: $dropdownvalueStatuses');
    } else {
      // Handle errors here
      print('Failed to fetch ticketStatuses: ${response.statusCode}');
    }
  }

  Future<void> getProblemTypes() async {
    //new code working class monday 11/27
    final response = await http.get(Uri.parse(
        '${Config.domain.scheme}://${Config.domain.host}/problemTypes'));
    if (response.statusCode == 200) {
      setState(() {
        problemTypes =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        dropdownvalueProblems = '1'; //widget.ticket['problemTypeId'].toString();
      });
      print(widget.ticket);
      print('Problems default: $dropdownvalueProblems');
    } else {
      // Handle errors here
      print('Failed to fetch problemTypes: ${response.statusCode}');
    }
  }

  Future<void> setTicketProblemType(String ticketId, int problemTypeId) async {
    String myVar =
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$ticketId?problemTypeId=$problemTypeId';
    print(myVar);
    final response = await http.put(Uri.parse(myVar));
  }

  Future<void> setTicketStatus(String ticketId, int statusId) async {
    String myVar =
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$ticketId?ticketStatusId=$statusId';
    print(myVar);
    final response = await http.put(Uri.parse(myVar));
  }

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await getTicketStatuses();
    await getProblemTypes();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getTicketStatuses();
    getProblemTypes();
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
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 12, 136, 136)),
                ),
                onPressed: () {
                  print('"Take Picture" Button Press');
                  //Logic to open the device camera and capture an image goes here.
                },
                child: const Text(
                  'Take Picture',
                  style: TextStyle(color: Colors.amberAccent),
                )),
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
            DropdownButton<String>(
              // Initial Value
              value: dropdownvalueStatuses,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: ticketStatuses.map((Map<String, dynamic> listItem) {
                return DropdownMenuItem(
                  value: listItem['id'].toString(),
                  child: Text(listItem['name'].toString()),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalueStatuses = newValue!;
                  setTicketStatus(widget.ticket.id, int.parse(newValue));
                });
              },
            ),
            DropdownButton<String>(
              // Initial Value
              value: dropdownvalueProblems,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: problemTypes.map((Map<String, dynamic> listItem) {
                return DropdownMenuItem(
                  value: listItem['id'].toString(),
                  child: Text(listItem['name'].toString()),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalueProblems = newValue!;
                  setTicketProblemType(
                      widget.ticket.id.toString(), int.parse(newValue));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
