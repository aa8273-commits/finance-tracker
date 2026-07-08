import 'package:finance/cubit/State_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final auth = FirebaseAuth.instance;

      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      emit(
        AuthSuccess(
          name: auth.currentUser!.displayName ?? '',
          email: auth.currentUser!.email ?? '',
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
    } catch (e) {
      emit(AuthError("Something went wrong"));
    }
  }
}
