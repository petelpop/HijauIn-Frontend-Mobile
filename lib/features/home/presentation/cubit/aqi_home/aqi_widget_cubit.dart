import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/home/data/models/aqi_home_model.dart';
import 'package:hijauin_frontend_mobile/features/home/data/services/services.dart';

part 'aqi_widget_state.dart';

class AqiWidgetCubit extends Cubit<AqiWidgetState> {
  final HomeServices _homeServices = HomeServices();

  AqiWidgetCubit() : super(AqiWidgetInitial());

  Future<void> fetchAqiData(double lat, double long) async {
    emit(AqiWidgetLoading());
    try {
      final aqiData = await _homeServices.getAqiData(lat, long);
      emit(AqiWidgetLoaded(aqiData));
    } catch (e) {
      emit(AqiWidgetError(e.toString()));
    }
  }
}
