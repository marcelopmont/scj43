import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scjo43/movies_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  LoginScreen({Key? key}) : super(key: key);

  var userEmail = '';
  var userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  // hintText: 'Email',
                ),
                onChanged: (newText) => userEmail = newText,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                  // hintText: 'Email',
                ),
                onChanged: (newText) => userPassword = newText,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  authenticateUser(context);
                },
                child: const Text('Logar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void authenticateUser(BuildContext context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    )
        .then(
      (user) {
        openMoviesScreen(context);
      },
    ).catchError(
      (error, stackTrace) {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        )
            .then((user) {
          openMoviesScreen(context);
        }).catchError(
          (error, stackTrace) {
            const snackBar = SnackBar(content: Text('Não foi possível logar'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('Não foi possível logar');
          },
        ).onError((error, stackTrace) {
          const snackBar = SnackBar(content: Text('Não foi possível logar'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print('Não foi possível logar');
        });
      },
    );
  }

  void openMoviesScreen(BuildContext context) {
    const snackBar = SnackBar(content: Text('Login realizado com sucesso'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamed(context, MoviesScreen.id);
  }
}
