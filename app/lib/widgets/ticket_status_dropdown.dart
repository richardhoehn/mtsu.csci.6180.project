
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
    return DropdownButton<String>(
      // Initial Value
      value: widget.ticket.ticketStatus.id.toString(),

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: ticketStatuses.map((TicketStatus ticketStatus) {
        return DropdownMenuItem(
          value: ticketStatus.id.toString(),
          child: Text(ticketStatus.name),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          widget.ticket.updateTicketStatus(ticketStatuses.firstWhere(
              (ticketStatus) => ticketStatus.id.toString() == newValue));
        });
      },
    );
  }
}
