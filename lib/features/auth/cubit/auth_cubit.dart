import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/repository/auth_remote_repository.dart';
import 'package:frontend/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRemoteRepository = AuthRemoteRepository();

  void signUp(
      {required String name,
      required String email,
      required String password}) async {

    try {
      emit(AuthLoading());
      await authRemoteRepository.signUp(
          name: name, email: email, password: password);
      emit(AuthSignUp());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void login({required String email, required String password})async {
    try {
      emit(AuthLoading());
      final userModel = await authRemoteRepository.login(
           email: email, password: password);
      emit(AuthLoggedIn(userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

}
