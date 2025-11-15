import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/history.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/services/services.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/cubit/history/history_cubit.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/payment_webview_page.dart';

class HistoryPage extends StatelessWidget {
  static const String routeName = 'history-page';
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(LapakServices())..fetchHistory(),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralColor50,
      appBar: AppBar(
        backgroundColor: whiteColor,
        foregroundColor: Colors.black,
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: whiteColor,
            child: const _FilterTabs(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor600,
                    ),
                  );
                }

                if (state is HistoryError) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: dangerColor500,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Gagal memuat riwayat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: neutralColor600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<HistoryCubit>().refreshHistory();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba Lagi'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor600,
                            foregroundColor: whiteColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is HistoryLoaded) {
                  final filteredTransactions = state.filteredTransactions;

                  if (filteredTransactions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: neutralColor400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada transaksi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: neutralColor900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.selectedFilter == 'pending'
                                ? 'Tidak ada transaksi yang menunggu pembayaran'
                                : state.selectedFilter == 'processing'
                                ? 'Tidak ada transaksi yang sedang dikemas'
                                : state.selectedFilter == 'shipped'
                                ? 'Tidak ada transaksi dalam perjalanan'
                                : state.selectedFilter == 'delivered'
                                ? 'Tidak ada transaksi yang selesai'
                                : state.selectedFilter == 'failed'
                                ? 'Tidak ada transaksi yang gagal'
                                : 'Anda belum memiliki riwayat transaksi',
                            style: TextStyle(
                              fontSize: 14,
                              color: neutralColor600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<HistoryCubit>().refreshHistory(),
                    color: primaryColor600,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return _TransactionCard(transaction: transaction);
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        final selectedFilter = state is HistoryLoaded ? state.selectedFilter : 'pending';

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: neutralColor200,
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: 'Pending',
                  isSelected: selectedFilter == 'pending',
                  onTap: () => context.read<HistoryCubit>().filterHistory('pending'),
                ),
                _FilterChip(
                  label: 'Pengemasan',
                  isSelected: selectedFilter == 'processing',
                  onTap: () => context.read<HistoryCubit>().filterHistory('processing'),
                ),
                _FilterChip(
                  label: 'Dalam Perjalanan',
                  isSelected: selectedFilter == 'shipped',
                  onTap: () => context.read<HistoryCubit>().filterHistory('shipped'),
                ),
                _FilterChip(
                  label: 'Selesai',
                  isSelected: selectedFilter == 'delivered',
                  onTap: () => context.read<HistoryCubit>().filterHistory('delivered'),
                ),
                _FilterChip(
                  label: 'Gagal',
                  isSelected: selectedFilter == 'failed',
                  onTap: () => context.read<HistoryCubit>().filterHistory('failed'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? primaryColor600 : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? primaryColor600 : neutralColor700,
          ),
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Datum transaction;

  const _TransactionCard({required this.transaction});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor500;
      case 'paid':
      case 'processing':
        return infoColor500;
      case 'shipped':
        return primaryColor600;
      case 'delivered':
        return successColor500;
      case 'cancelled':
      case 'failed':
        return dangerColor500;
      default:
        return neutralColor500;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu Pembayaran';
      case 'paid':
        return 'Pengemasan';
      case 'processing':
        return 'Pengemasan';
      case 'shipped':
        return 'Dalam Perjalanan';
      case 'delivered':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      case 'failed':
        return 'Gagal';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'paid':
      case 'processing':
        return Icons.inventory_2_outlined;
      case 'shipped':
        return Icons.local_shipping_outlined;
      case 'delivered':
        return Icons.check_circle_outline;
      case 'cancelled':
      case 'failed':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstItem = transaction.items.isNotEmpty ? transaction.items.first : null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: neutralColor200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: neutralColor50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: neutralColor200),
              ),
              child: Center(
                child: Icon(
                  Icons.inventory_2_outlined,
                  size: 40,
                  color: neutralColor400,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          firstItem?.productName ?? 'Produk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: neutralColor900,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${firstItem?.quantity ?? 1}x',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2D746A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    transaction.totalAmountFormatted,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryColor600,
                    ),
                  ),
                ],
              ),
            ),
            
            if (transaction.status.toLowerCase() == 'pending') ...[
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebViewPage(
                        paymentUrl: transaction.paymentUrl,
                        transactionId: transaction.id,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryColor600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Bayar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
