import 'package:app/screens/ticket.dart';
import 'package:app/services/ticket.dart';
import 'package:flutter/material.dart';

class PickUpListTileWidget extends StatelessWidget {
  PickUpListTileWidget({super.key, required this.ticket});
  Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket.name),
      subtitle: Text(ticket.licencePlate),
      onTap: () {
        print('Tapped! ${ticket.id}');
      },
      trailing: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          ),
          onPressed: () {
            print('Button Pressed!!!');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TicketScreen(),
              ),
            );
          },
          child: Text(
            'Go',
            style: TextStyle(color: Colors.amberAccent),
          )),
    );
  }
}
