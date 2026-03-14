import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Nadodi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (auth.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(auth.error!, style: const TextStyle(color: Colors.red)),
              ),
            ElevatedButton(
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      if (_isRegistering) {
                        await auth.signUp(_emailController.text.trim(), _passwordController.text.trim());
                      } else {
                        await auth.signIn(_emailController.text.trim(), _passwordController.text.trim());
                      }
                      if (auth.user != null) {
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                        }
                      }
                    },
              child: Text(_isRegistering ? 'Create account' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering;
                });
              },
              child: Text(_isRegistering ? 'Already have an account? Login' : 'Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
