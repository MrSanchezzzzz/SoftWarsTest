import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.35,
            ),
            ElevatedButton(
                onPressed: (){
                  context.go('/');
                },
                child: const Text('Вхід')
            ),
          ],
        ),
      ),
    );
  }
}
