import 'package:finance/views/home_view.dart';
import 'package:finance/widgets/TextField_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/cubit/login_cubit.dart';
import 'package:finance/cubit/State_cubit.dart';
import 'package:finance/helper/showsnakbar.dart';
import 'package:finance/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showSnakbar(context, state.message);
          }

          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, HomeView.id);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: const Color(0xFF0B0C1F),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0B0C1F),
                    Color(0xFF1C1E6B),
                    Color(0xFF383BCE),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFF383BCE).withOpacity(0.3),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// TITLE
                        const Text(
                          "WELCOME BACK",
                          style: TextStyle(
                            color: Color(0xFF6A6EF5),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 25),

                        const SizedBox(height: 15),

                        TextFieldWidget(
                          hint: "Email",
                          icon: Icons.email,
                          onChanged: (v) => email = v,
                        ),

                        const SizedBox(height: 15),

                        TextFieldWidget(
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: true,
                          onChanged: (v) => password = v,
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF383BCE),
                              shadowColor: const Color(0xFF383BCE),
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    cubit.login(
                                      email: email,
                                      password: password,
                                    );
                                  },
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: const Text(
                            "Create new account",
                            style: TextStyle(color: Color(0xFF6A6EF5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
