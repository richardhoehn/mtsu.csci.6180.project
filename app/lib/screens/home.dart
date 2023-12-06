import 'package:app/screens/drop_off.dart';
import 'package:app/screens/pick_up.dart';
import 'package:app/util/config.dart';
import 'package:app/widgets/map_sample.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(
          Config.images.squareWhiteLogo,
          fit: BoxFit.contain,
          height: 100,
        ),
        toolbarHeight: 120,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Welcome to Valet Buddy!',
                  style: TextStyle(fontSize: 36),
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
                              side: BorderSide(color: Config.colors.backgroundColor, width: 2),
                            ),
                          ),
                        ),
                        onPressed: () {
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
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Config.colors.backgroundColor, width: 2),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (context) => PickUpScreen());
                          Navigator.push(context, route);
                        },
                        child: const Text('Pick Up', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
