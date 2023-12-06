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

  Future<void> update(int problemTypeId) async {
    print("Updating Problem Type: $problemTypeId");
    await widget.ticket.updateProblemType(problemTypes.firstWhere((problemType) => problemType.id == problemTypeId));
    setState(() {
      print("Complted Problem Type Update!");
    });
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
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      underline: const SizedBox(),
      value: widget.ticket.problemType.id, // Initial Value
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.amberAccent),

      items: problemTypes.map((ProblemType problemType) {
        return DropdownMenuItem(
          value: problemType.id,
          child: Text(problemType.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        );
      }).toList(),

      onChanged: (int? newValue) async {
        print('OnChange: $newValue');
        await update(newValue!);
      },
    );
  }
}
