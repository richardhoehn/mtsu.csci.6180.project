import 'package:app/services/problem_type.dart';
import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProblemTypeDropdown extends StatefulWidget {
  ProblemTypeDropdown({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<ProblemTypeDropdown> createState() => _ProblemTypeDropdownState();
}

class _ProblemTypeDropdownState extends State<ProblemTypeDropdown> {
  Dio dio = DioClient().dio;
  List<ProblemType> problemTypes = [];
  bool isRefreshing = false;

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
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // Initial Value
      value: widget.ticket.problemType.id.toString(),

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
          print(newValue);
          widget.ticket.updateProblemType(problemTypes.firstWhere(
              (problemType) => problemType.id.toString() == newValue));
        });
      },
    );
  }
}
