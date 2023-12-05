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

    final String subtitleString = 'Lic. Plate: ${ticket.licencePlate}\nStatus: ${ticket.ticketStatus.name}\nProblem: ${ticket.problemType.name}';

    return ListTile(
      title: Text(ticket.name),
      subtitle: Text(subtitleString),
      leading: TicketImageWidget(ticket: ticket),
      trailing: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TicketScreen(ticket: ticket),
              ),
            ).then((value) => onPressed());
          },
          child: const Text(
            'Go',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
