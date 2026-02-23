import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/dio_client.dart';
import '../../feed/ui/feed_page.dart';
import '../data/auth_remote_datasource.dart';
import 'login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final login = LoginViewModel(
    AuthRepositoryImpl(
      AuthRemoteDataSource(DioClient().dio),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Observer(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    const Icon(Icons.lock_person_sharp, size: 80),

                    const SizedBox(height: 16),

                    const Text(
                      "Bem-vindo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Usuário",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: login.setUsername,
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: login.setPassword,
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: login.loading ? null : () async {
                        final authUser = await login.login();

                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FeedPage(
                                username: authUser.username,
                                token: authUser.token,
                              ),
                            ),
                          );
                        }
                      },
                      child: login.loading
                          ? const CircularProgressIndicator()
                          : const Text("Entrar"),
                    ),



                    if (login.errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        login.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

