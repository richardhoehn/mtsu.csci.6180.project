import 'package:app/services/ticket.dart';
import 'package:flutter/material.dart';

class TicketNameRow extends StatelessWidget {
  const TicketNameRow({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(text: 'Name:'),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: ticket.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                      fontSize: 24,
                    ),
                  ),
                ])),
          ),
          Expanded(
            child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(text: 'Vehicle'),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: ticket.licencePlate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                      fontSize: 24,
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }
}
