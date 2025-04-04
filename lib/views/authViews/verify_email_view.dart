import 'package:dairl/services/auth/auth_exception.dart';
import 'package:dairl/services/auth/auth_service.dart';
import 'package:dairl/services/auth/bloc/auth_bloc.dart';
import 'package:dairl/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email verification')),
      body: Column(
        children: [
          const Text(
            "We've sent you an email verification. Please go verify your account",
          ),
          const Text(
            "If you haven't received a verification email yet, press the button below",
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
            onPressed: () async {
              try {
                context.read<AuthBloc>().add(AuthEventLogOut());
              } catch (e) {
                throw GenericAuthException();
              }
            },
            child: const Text("Go back"),
          ),
        ],
      ),
    );
  }
}
