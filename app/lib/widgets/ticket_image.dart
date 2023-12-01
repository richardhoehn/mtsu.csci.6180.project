import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:flutter/material.dart';

class TicketImageWidget extends StatelessWidget {
  const TicketImageWidget({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Config.colors.backgroundColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: AspectRatio(
            aspectRatio: 1,
            child: FadeInImage.assetNetwork(
              placeholder: Config.images.vehiclePlaceholder,
              image: '${Config.domain.scheme}://${Config.domain.host}/tickets/${ticket.id}/images',
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(Config.images.vehiclePlaceholder, fit: BoxFit.fitWidth);
              },
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
