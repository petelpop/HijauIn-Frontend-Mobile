import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/service/waste_map_service.dart';

part 'waste_map_state.dart';

class WasteMapCubit extends Cubit<WasteMapState> {
  final WasteMapService _wasteMapService = WasteMapService();

  WasteMapCubit() : super(WasteMapInitial());

  Future<void> fetchWasteLocationsByCategory(
    double lat,
    double lng,
    String category,
  ) async {
    emit(WasteMapLoading());
    try {
      final wasteLocation = await _wasteMapService.getWasteLocationsByCategory(
        lat,
        lng,
        [category],
      );
      emit(WasteMapLoaded(wasteLocation));
    } catch (e) {
      emit(WasteMapError(e.toString()));
    }
  }
}
