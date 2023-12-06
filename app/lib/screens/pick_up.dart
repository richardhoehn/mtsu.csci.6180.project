import 'package:app/services/server_interface.dart';
import 'package:app/services/ticket.dart';
import 'package:app/widgets/pick_up_list_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/util/config.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  Dio dio = DioClient().dio;
  List<Ticket> tickets = List.empty(growable: true);
  bool isRefreshing = false;
  String _searchText = '';
  final TextEditingController _controller = TextEditingController();

  Future<void> onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    tickets = await DioClient().getAllTickets();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final _filteredTickets = tickets
        .where((ticket) =>
            ticket.name.toLowerCase().contains(_searchText.toLowerCase()) ||
            ticket.licencePlate.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

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
            // Add your back button logic here
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'PickUp Screen',
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Config.colors.backgroundColor, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Search:', style: TextStyle(fontSize: 24)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      cursorColor: Config.colors.iconColor,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Config.colors.iconColor),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Config.colors.iconColor),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchText = '';
                        _controller.clear();
                        // Close the keyboard by requesting focus elsewhere
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    child: Icon(
                      Icons.clear,
                      color: Config.colors.iconColor,
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: _filteredTickets.length,
                  itemBuilder: (context, index) {
                    return PickUpListTileWidget(ticket: _filteredTickets[index], onPressed: onRefresh);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
