import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/services/sp_services.dart';
import 'package:frontend/features/auth/repository/auth_local_reposistory.dart';
import 'package:frontend/features/auth/repository/auth_remote_repository.dart';
import 'package:frontend/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRemoteRepository = AuthRemoteRepository();
  final spService = SpService();
  final authLocalRepository = AuthLocalRepository();

  void getUserData() async {
    try {
      emit(AuthLoading());
      final userModel = await authRemoteRepository.getUserData();
      if (userModel != null) {
       final userModel= await authLocalRepository.getUser();
        emit(AuthLoggedIn(userModel!));
        return ;
      }
      emit(AuthInitial());
    } catch (e) {
      emit(AuthInitial());
    }
  }

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

  void login({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final userModel =
          await authRemoteRepository.login(email: email, password: password);
      print("reache here");
      if (userModel.token != null) {
        print("token is ${userModel.token}");
        spService.setToken(userModel.token!);
      }
      await authLocalRepository.insertUser(userModel);
      emit(AuthLoggedIn(userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
