import 'package:app/screens/ticket.dart';
import 'package:app/services/ticket.dart';
import 'package:app/widgets/ticket_image.dart';
import 'package:flutter/material.dart';

class PickUpListTileWidget extends StatelessWidget {
  PickUpListTileWidget({super.key, required this.ticket});
  Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket.name),
      subtitle: Text(ticket.licencePlate),
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
            );
          },
          child: const Text(
            'Go',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
