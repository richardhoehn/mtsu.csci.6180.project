import 'package:app/screens/ticket.dart';
import 'package:flutter/material.dart';

class PickUpListTileWidget extends StatelessWidget {
  PickUpListTileWidget({super.key, required this.ticket});
  Map<String, dynamic> ticket;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket['licencePlate'].toString() ?? '--'),
      subtitle: Text(ticket['name'].toString() ?? '---'),
      onTap: () {
        print('Tapped! ${ticket['name'].toString()}');
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
