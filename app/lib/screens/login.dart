import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/config.dart';
import 'dart:convert';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Future<bool> auth() async {
    final response = await http.post(Uri.parse('${Config.domain.scheme}://${Config.domain.host}/users/auth'));
    print('****');
    print(response.body);
    print('****');

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Login Screen',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.colors.backgroundColor,
                    foregroundColor: Config.colors.textColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    final resp = await auth();
                    ref.read(loginProvider.notifier).state = resp;
                  },
                  child: const Text('Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
