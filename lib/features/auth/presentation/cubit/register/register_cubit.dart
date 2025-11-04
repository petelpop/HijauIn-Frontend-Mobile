import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/register_request.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/services/services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  
  AuthServices authServices = AuthServices();

  void register(RegisterRequest payload) async {
    emit(RegisterLoading());
    final result = await authServices.register(payload);

    result.fold(
      (failure) {
        emit(RegisterFailed(message: failure.message));
        print("error: ${failure.message}");
      },
      (_) => emit(const RegisterSuccess(message: 'Registrasi berhasil')),
    );
  }
}
