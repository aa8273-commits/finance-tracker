import 'package:finance/cubit/State_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(AuthInitial());
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());

    try {
      if (!email.endsWith("@gmail.com")) {
        emit(AuthError("Only Gmail allowed"));
        return;
      }

      if (password.length < 8) {
        emit(AuthError("Min 8 characters"));
        return;
      }

      if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])').hasMatch(password)) {
        emit(AuthError("Need uppercase + number"));
        return;
      }

      final auth = FirebaseAuth.instance;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user!.updateDisplayName(name);

      await userCredential.user!.reload();

      final currentUser = FirebaseAuth.instance.currentUser;

      emit(
        AuthSuccess(
          name: currentUser?.displayName ?? "",
          email: currentUser?.email ?? "",
        ),
      );

      // تسجيل الخروج بعد إنشاء الحساب
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Registration Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
