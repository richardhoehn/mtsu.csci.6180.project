import 'package:app/main.dart';
import 'package:app/screens/camera_app.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/widgets/take_picture_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/util/config.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  AuthService authService = AuthService();

  bool isLoading = false;
  String errorText = '';

  Future<bool> auth() async {
    // Set Loading Flag
    isLoading = true;
    errorText = '';
    setState(() {});

    // Minor Delay for Effect(!)
    await Future.delayed(const Duration(seconds: 1), () {});

    try {
      await authService.login(email: emailCtrl.text, password: passwordCtrl.text);
    } catch (error) {
      print(error);
      errorText = 'Login Failed!';
    } finally {
      print('Finally');
      setState(() => isLoading = false);
    }

    return authService.isLoggedIn;
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email like abc@gmail.com',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password',
                      ),
                    ),
                  ),
                  errorText != ''
                      ? Text(
                          errorText,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      : const SizedBox(),
                  Center(
                    child: Consumer(builder: (context, ref, _) {
                      return isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Config.colors.backgroundColor,
                                foregroundColor: Config.colors.textColor,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                final success = await auth();
                                ref.read(loginProvider.notifier).state = success;
                              },
                              child: const Text('Login'),
                            );
                    }),
                  ),
                  TakePictureButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
