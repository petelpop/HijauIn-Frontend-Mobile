import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/aqi_location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/services/services.dart';

part 'aqi_map_state.dart';

class AqiMapCubit extends Cubit<AqiMapState> {
  final MapinServices _mapinServices = MapinServices();

  AqiMapCubit() : super(AqiMapInitial());

  Future<void> fetchAqiLocations(double lat, double lng) async {
    try {
      emit(AqiMapLoading());
      final aqiLoka = await _mapinServices.getAqiMapLocations(lat, lng);
      emit(AqiMapLoaded(aqiLoka));
    } catch (e) {
      emit(AqiMapError(e.toString()));
    }
  }
}
