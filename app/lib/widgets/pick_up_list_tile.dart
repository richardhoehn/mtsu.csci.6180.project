import 'package:app/screens/ticket.dart';
import 'package:app/services/ticket.dart';
import 'package:app/widgets/ticket_image.dart';
import 'package:flutter/material.dart';

class PickUpListTileWidget extends StatelessWidget {
  const PickUpListTileWidget({super.key, required this.ticket, required this.onPressed});
  final Ticket ticket;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final String subtitleString =
        'Lic. Plate: ${ticket.licencePlate}\nStatus: ${ticket.ticketStatus.name}\nProblem: ${ticket.problemType.name}';

    return ListTile(
      title: Text(
        ticket.name,
        style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: RichText(
        text: TextSpan(
          text: 'Lic. Plate: ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: ticket.licencePlate,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent, fontSize: 18),
            ),
          ],
        ),
      ),
      leading: TicketImageWidget(ticket: ticket),
      trailing: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: 'Status: ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: ticket.ticketStatus.name,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent, fontSize: 18),
            ),
            const TextSpan(text: '\n'),
            ticket.problemType.id != 1 ? TextSpan(
              text: 'Problem: ',
            ) : TextSpan(),
            ticket.problemType.id != 1 ? TextSpan(
              text: ticket.problemType.name,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent, fontSize: 18),
            ) : TextSpan(),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => TicketScreen(ticket: ticket),
              ),
            )
            .then((value) => onPressed());
      },
    );
  }
}
