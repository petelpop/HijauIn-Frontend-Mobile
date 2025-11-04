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
      (loginData) {
        emit(LoginSuccess(loginData: loginData));
        print("Login success: ${loginData.message}");
      },
    );
  }
}
