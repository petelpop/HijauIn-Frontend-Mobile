import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sortir_state.dart';

class SortirCubit extends Cubit<SortirState> {
  SortirCubit() : super(SortirInitial());
}
