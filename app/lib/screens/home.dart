import 'package:app/screens/drop_off.dart';
import 'package:app/screens/pick_up.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Valet Buddy')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Home Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 2,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print('Pick Up - Pressed');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PickUpScreen(),
                            ),
                          );
                        },
                        child: const Text('Pick Up', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print('Drop Off - Pressed');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DropOffScreen(),
                            ),
                          );
                        },
                        child: const Text('Drop Off', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
