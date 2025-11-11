import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/login.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/login_request.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/services/services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  
  AuthServices authServices = AuthServices();

  void login(LoginRequest payload) async {
    emit(LoginLoading());
    final result = await authServices.login(payload);

    result.fold(
      (failure) {
        emit(LoginFailed(message: failure.message));
        print("Login error: ${failure.message}");
      },
      (loginData) async {
        emit(LoginSuccess(loginData: loginData));
        print("Login success: ${loginData.message}");
      },
    );
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await authServices.isLoggedIn();
    if (isLoggedIn) {
      final userData = await authServices.getCurrentUser();
      final token = await authServices.getAccessToken();
      
      if (userData != null && token != null) {
        final loginData = LoginData(
          message: 'Auto login',
          accessToken: token,
          user: userData,
        );
        emit(LoginSuccess(loginData: loginData));
      }
    }
  }

  Future<void> logout() async {
    await authServices.logout();
    emit(LoginInitial());
    print("User logged out and data cleared");
  }
}
