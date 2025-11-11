import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/forgot_request.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/services/services.dart';

part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());
  
  AuthServices authServices = AuthServices();

  void forgotPassword(ForgotRequest payload) async {
    emit(ForgotLoading());
    final result = await authServices.forgotPassword(payload);

    result.fold(
      (failure) {
        emit(ForgotFailed(message: failure.message));
        print("Forgot password error: ${failure.message}");
      },
      (message) {
        emit(ForgotSuccess(message: message));
        print("Forgot password success: $message");
      },
    );
  }
}
