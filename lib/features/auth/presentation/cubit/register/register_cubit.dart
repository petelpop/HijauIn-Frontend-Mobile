import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/models/register.dart';
import 'package:hijauin_frontend_mobile/features/auth/data/services/services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({AuthServices? authServices})
      : _authServices = authServices ?? AuthServices(),
        super(RegisterInitial());

  final AuthServices _authServices;

  Future<void> register(Register payload) async {
    emit(RegisterLoading());
    final result = await _authServices.register(payload);

    result.fold(
      (failure) {
        emit(RegisterFailed(message: failure.message));
        print("error: ${failure.message}");
      },
      (_) => emit(const RegisterSuccess( message: 'Registrasi berhasil')),
    );
  }
}
