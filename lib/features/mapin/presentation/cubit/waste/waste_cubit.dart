import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/services/services.dart';

part 'waste_state.dart';

class WasteCubit extends Cubit<WasteState> {
  final MapinServices _mapinServices = MapinServices();

  WasteCubit() : super(WasteInitial());

  Future<void> fetchWasteLocations(double lat, double lng) async {
    emit(WasteLoading());
    try {
      final wasteLocation = await _mapinServices.getWasteLocations(lat, lng);
      emit(WasteLoaded(wasteLocation));
    } catch (e) {
      emit(WasteError(e.toString()));
    }
  }

  Future<void> fetchWasteLocationsByCategory(
    double lat,
    double lng,
    List<String> categories,
  ) async {
    emit(WasteLoading());
    try {
      final wasteLocation = await _mapinServices.getWasteLocationsByCategory(
        lat,
        lng,
        categories,
      );
      emit(WasteLoaded(wasteLocation));
    } catch (e) {
      emit(WasteError(e.toString()));
    }
  }
}
