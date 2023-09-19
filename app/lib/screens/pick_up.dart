import 'package:flutter/material.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text('Valet Buddy')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use any icon you prefer
          onPressed: () {
            // Add your back button logic here
            Navigator.of(context).pop(); // Typically used to navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'PickUp Screen',
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
