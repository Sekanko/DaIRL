import 'package:dairl/constants/authSettings.dart';
import 'package:dairl/constants/colors.dart';
import 'package:dairl/constants/routes.dart';
import 'package:dairl/services/auth/auth_exception.dart';
import 'package:dairl/services/auth/bloc/auth_bloc.dart';
import 'package:dairl/services/auth/bloc/auth_event.dart';
import 'package:dairl/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: authViewGradientColors),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(standardBodyPadding),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Email"),
                        ),
                      ),
                      TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Password"),
                        ),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            context.read<AuthBloc>().add(
                              AuthEventRegister(email, password),
                            );
                          } on WeakPasswordAuthException {
                            await showErrorDialog(context, 'Week password');
                          } on EmailAlreadyInUseAuthException {
                            await showErrorDialog(
                              context,
                              'Email is already in use',
                            );
                          } on InvalidEmailAuthException {
                            await showErrorDialog(
                              context,
                              'Invalid email entered',
                            );
                          } on GenericAuthException {
                            await showErrorDialog(
                              context,
                              'Authentication error',
                            );
                          }
                        },
                        child: const Text("Register"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventWantToLogIn());
                        },
                        child: Text('Already registered? Login here!'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
