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
            const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'PickUp Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Search:', style: TextStyle(color: Config.colors.iconColor)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Config.colors.iconColor),
                      cursorColor: Config.colors.iconColor,
                      decoration: InputDecoration(
                        hintText: '...',
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
                  ElevatedButton(
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
                    return PickUpListTileWidget(ticket: _filteredTickets[index]);
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
