import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:app/widgets/problem_type_dropdown.dart';
import 'package:flutter/material.dart';

class ProblemTypeRow extends StatelessWidget {
  ProblemTypeRow({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            border: Border.all(color: Config.colors.backgroundColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Problem Type:'),
          Spacer(),
          ProblemTypeDropDown(ticket: ticket),
        ],
      ),
    );
  }
}
