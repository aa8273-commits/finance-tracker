import 'package:finance/widgets/TextField_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/cubit/Register_cubit.dart';
import 'package:finance/cubit/State_cubit.dart';
import 'package:finance/helper/showsnakbar.dart';
import 'package:finance/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showSnakbar(context, state.message);
          }

          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, LoginView.id);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

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
                          "CREATE ACCOUNT",
                          style: TextStyle(
                            color: Color(0xFF6A6EF5),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// NAME
                        TextFieldWidget(
                          hint: "Name",
                          icon: Icons.person,
                          onChanged: (v) => name = v,
                        ),

                        const SizedBox(height: 15),

                        /// EMAIL
                        TextFieldWidget(
                          hint: "Email",
                          icon: Icons.email,
                          onChanged: (v) => email = v,
                        ),

                        const SizedBox(height: 15),

                        TextFieldWidget(
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: cubit.isPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(
                              cubit.isPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          onChanged: (v) => password = v,
                        ),

                        const SizedBox(height: 25),

                        /// BUTTON
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
                                    cubit.register(
                                      name: name,
                                      email: email,
                                      password: password,
                                      context: context,
                                    );
                                  },
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "CREATE ACCOUNT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// LOGIN LINK
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginView.id);
                          },
                          child: const Text(
                            "Already have an account? Login",
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
