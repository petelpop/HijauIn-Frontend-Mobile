part of 'history_cubit.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final HistoryData historyData;
  final String selectedFilter; 

  const HistoryLoaded({
    required this.historyData,
    this.selectedFilter = 'pending',
  });

  @override
  List<Object> get props => [historyData, selectedFilter];

  HistoryLoaded copyWith({
    HistoryData? historyData,
    String? selectedFilter,
  }) {
    return HistoryLoaded(
      historyData: historyData ?? this.historyData,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  List<Datum> get filteredTransactions {
    if (selectedFilter == 'all') return historyData.data;

    return historyData.data.where((transaction) {
      final status = transaction.status.toLowerCase();
      
      switch (selectedFilter) {
        case 'pending':
          return status == 'pending';
        case 'processing':
          return status == 'paid' || status == 'processing';
        case 'shipped':
          return status == 'shipped';
        case 'delivered':
          return status == 'delivered';
        case 'failed':
          return status == 'cancelled' || status == 'failed';
        default:
          return true;
      }
    }).toList();
  }
}

final class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
