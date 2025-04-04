import 'package:dairl/constants/routes.dart';
import 'package:dairl/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/auth/bloc/auth_bloc.dart';
import 'services/auth/bloc/auth_event.dart';
import 'services/auth/bloc/auth_state.dart';
import 'services/auth/firebase_auth_provider.dart';
import 'views/authViews/login_view.dart';
import 'views/authViews/register_view.dart';
import 'views/authViews/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login przeszedł'),
              backgroundColor: Colors.white,
            ),
            body: TextButton(
              onPressed: () {
                AuthService.firebase().logOut();
                context.read<AuthBloc>().add(AuthEventLogOut());
              },
              child: Text("Logout"),
            ),
          );
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut ||
            state is AuthStateWantToLogIn) {
          return const LoginView();
        } else if (state is AuthStateWantToRegister) {
          return const RegisterView();
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              ),
            ),
          );
        }
      },
    );
  }
}
