import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/services/ticket_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TicketStatusDropdown extends StatefulWidget {
  TicketStatusDropdown({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<TicketStatusDropdown> createState() => _TicketStatusDropdownState();
}

class _TicketStatusDropdownState extends State<TicketStatusDropdown> {
  Dio dio = DioClient().dio;
  List<TicketStatus> ticketStatuses = [];
  bool isRefreshing = false;

  Future<void> update(int ticketStatusId) async {
    print("Updating Ticket Status: $ticketStatusId");
    await widget.ticket.updateTicketStatus(ticketStatuses.firstWhere((ticketStatus) => ticketStatus.id == ticketStatusId));
    setState(() {
      print("Completed Ticket Status Update!");
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    ticketStatuses = await DioClient().getAllTicketStatuses();

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
    return DropdownButton<int>(
      underline: const SizedBox(),
      value: widget.ticket.ticketStatus.id, // Initial Value
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.amberAccent),

      items: ticketStatuses.map((TicketStatus ticketStatus) {
        return DropdownMenuItem(
          value: ticketStatus.id,
          child: Text(ticketStatus.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        );
      }).toList(),

      onChanged: (int? newValue) async {
        print('OnChange: $newValue');
        await update(newValue!);
      },
    );
  }
}
