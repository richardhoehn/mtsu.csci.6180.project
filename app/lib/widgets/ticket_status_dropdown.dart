import 'package:app/services/problem_type.dart';
import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/services/ticket_status.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class TicketStatusDropDown extends StatefulWidget {
  TicketStatusDropDown({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<TicketStatusDropDown> createState() => _ProblemTypeDropDownState();
}

class _ProblemTypeDropDownState extends State<TicketStatusDropDown> {
  Dio dio = DioClient().dio;
  List<TicketStatus> ticketStatuses = [];
  bool isRefreshing = false;
  String dropdownvalueStatuses =
      '2'; //Default value that is changed in initState()

  Future<void> setTicketStatus(String ticketId, int ticketStatusId) async {
    final response = await http.put(Uri.parse(
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$ticketId?ticketStatusId=$ticketStatusId'));
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
    return DropdownButton<String>(
      // Initial Value
      value: dropdownvalueStatuses,

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
          dropdownvalueStatuses = newValue!;
          setTicketStatus(widget.ticket.id, int.parse(newValue));
        });
      },
    );
  }
}
