import 'package:app/services/problem_type.dart';
import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class ProblemTypeDropDown extends StatefulWidget {
  ProblemTypeDropDown({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<ProblemTypeDropDown> createState() => _ProblemTypeDropDownState();
}

class _ProblemTypeDropDownState extends State<ProblemTypeDropDown> {
  Dio dio = DioClient().dio;
  List<Map<String, dynamic>> ticketStatuses = [];
  List<ProblemType> problemTypes = [];
  bool isRefreshing = false;
  String dropdownvalueStatuses =
      '2'; //Default value that is changed in initState()
  String dropdownvalueProblems =
      '1'; //Default value that is changed in initState()

  Future<void> setTicketProblemType(String ticketId, int problemTypeId) async {
    String myVar =
        '${Config.domain.scheme}://${Config.domain.host}/tickets/$ticketId?problemTypeId=$problemTypeId';
    //print(myVar);
    final response = await http.put(Uri.parse(myVar));
  }

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    problemTypes = await DioClient().getAllProblemTypes();

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
    return
          DropdownButton<String>(
            // Initial Value
            value: dropdownvalueProblems,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: problemTypes.map((ProblemType problemType) {
              return DropdownMenuItem(
                value: problemType.id.toString(),
                child: Text(problemType.name),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalueProblems = newValue!;
                setTicketProblemType(
                    widget.ticket.id, int.parse(newValue));
              });
            },
          );
  }
}
