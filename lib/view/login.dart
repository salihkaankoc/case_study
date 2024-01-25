import 'package:case_study/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final container = ProviderContainer();
    var userToken = StateProvider<String>((ref) => "");
    void login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
        try {
          final result = await container.read(loginProvider(Params(
                  email: emailController.text, password: passController.text))
              .future);

          if (result['token'] == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kullanıcı bulunamadı.')));
          } else {
            ref.read(userToken.notifier).state = result['token'];
            prefs.setString('token', result['token']);
            Navigator.pushNamed(context, "/home");
          }
        } catch (error) {
          print('Error: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lütfen tüm alanları doldurun.')));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Study Case',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        fixedSize: const Size(180, 40)),
                    onPressed: () => login(),
                    child: const Text(
                      'Giriş Yap',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
