import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/history.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/utils/logger_service.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final LapakServices _lapakServices;

  HistoryCubit(this._lapakServices) : super(HistoryInitial());

  Future<void> fetchHistory() async {
    try {
      emit(HistoryLoading());
      final historyData = await _lapakServices.getHistory();
      emit(HistoryLoaded(historyData: historyData));
      LoggerService.info('History fetched successfully');
    } catch (e) {
      LoggerService.error('Error fetching history: $e');
      emit(HistoryError(e.toString()));
    }
  }

  void filterHistory(String filter) {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      emit(currentState.copyWith(selectedFilter: filter));
      LoggerService.info('History filtered by: $filter');
    }
  }

  Future<void> refreshHistory() async {
    await fetchHistory();
  }
}
