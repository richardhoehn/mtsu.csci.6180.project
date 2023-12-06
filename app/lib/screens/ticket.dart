import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/widgets/location_button.dart';
import 'package:app/widgets/map_box.dart';
import 'package:app/widgets/problem_type_row.dart';
import 'package:app/widgets/take_picture_button.dart';
import 'package:app/widgets/ticket_image.dart';
import 'package:app/widgets/ticket_name_row.dart';
import 'package:app/widgets/ticket_status_row.dart';
import 'package:app/widgets/updated_by_row.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/util/config.dart';

class TicketScreen extends StatefulWidget {
  TicketScreen({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  Dio dio = DioClient().dio;
  bool isRefreshing = false;

  Future<void> onRefresh() async {

    setState(() {
      isRefreshing = true;
    });

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Image.asset(
          Config.images.squareWhiteLogo,
          fit: BoxFit.contain,
          height: 36,
        ),
        toolbarHeight: 55,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // You can use any icon you prefer
          onPressed: () {
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TicketNameRow(ticket: widget.ticket),
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TakePictureButton(ticket: widget.ticket),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: LocationButton(ticket: widget.ticket),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: MapBox(ticket: widget.ticket),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: TicketImageWidget(ticket: widget.ticket),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TicketStatusRow(ticket: widget.ticket),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: ProblemTypeRow(ticket: widget.ticket),
                    ),
                    UpdatedByRow(ticket: widget.ticket),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
