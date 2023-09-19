import 'package:flutter/material.dart';

class DropOffScreen extends StatelessWidget {
  const DropOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Valet Buddy')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // You can use any icon you prefer
          onPressed: () {
            // Add your back button logic here
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Drop Off Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
