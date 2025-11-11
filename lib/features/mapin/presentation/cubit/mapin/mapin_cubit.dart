import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mapin_state.dart';

class MapinCubit extends Cubit<MapinState> {
  MapinCubit() : super(MapinInitial());

  void setMode(MapMode mode) {
    emit(MapModeChanged(mode: mode));
  }
}
