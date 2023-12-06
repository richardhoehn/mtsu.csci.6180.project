import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdatedByRow extends StatelessWidget {
  const UpdatedByRow({super.key, required this.ticket});
  final Ticket ticket;
  final dateFormatString = 'EE, MMM d, @ h:mm a';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: 'Created:'),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text: DateFormat(dateFormatString).format(ticket.createAt.toLocal()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent,
                            fontSize: 12,
                          ),
                        ),
                      ])),
                ),
                Expanded(
                  child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: 'Updated'),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text: DateFormat(dateFormatString).format(ticket.updateAt.toLocal()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent,
                            fontSize: 12,
                          ),
                        ),
                      ])),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'ID\n${ticket.id}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
