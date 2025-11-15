import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/detail_lapak.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';

part 'detail_lapak_state.dart';

class DetailLapakCubit extends Cubit<DetailLapakState> {
  final LapakServices _services;

  DetailLapakCubit(this._services) : super(DetailLapakInitial());

  Future<void> fetchProductDetail(String productId) async {
    emit(DetailLapakLoading());
    try {
      final result = await _services.getProductDetail(productId);
      emit(DetailLapakLoaded(result));
    } catch (e) {
      emit(DetailLapakError(e.toString()));
    }
  }
}
