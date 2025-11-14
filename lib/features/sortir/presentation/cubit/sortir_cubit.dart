import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/model/sortir.dart';
import 'package:hijauin_frontend_mobile/features/sortir/data/service/service.dart';

part 'sortir_state.dart';

class SortirCubit extends Cubit<SortirState> {
  final SortirService _sortirService;

  SortirCubit(this._sortirService) : super(SortirInitial());

  Future<void> loadModel() async {
    try {
      emit(SortirLoading());
      await _sortirService.loadModel();
      emit(SortirModelLoaded());
    } catch (e) {
      emit(SortirError('Gagal memuat model: $e'));
    }
  }

  Future<void> pickAndClassifyFromCamera() async {
    try {
      emit(SortirClassifying());
      
      final File? image = await _sortirService.pickImageFromCamera();
      
      if (image == null) {
        emit(SortirModelLoaded());
        return;
      }

      await _classifyImage(image);
    } catch (e) {
      emit(SortirError('Gagal mengambil foto: $e'));
    }
  }

  Future<void> pickAndClassifyFromGallery() async {
    try {
      emit(SortirClassifying());
      
      final File? image = await _sortirService.pickImageFromGallery();
      
      if (image == null) {
        emit(SortirModelLoaded());
        return;
      }

      await _classifyImage(image);
    } catch (e) {
      emit(SortirError('Gagal memilih gambar: $e'));
    }
  }

  Future<void> _classifyImage(File image) async {
    try {
      final recognitions = await _sortirService.classifyImage(image);
      
      if (recognitions == null || recognitions.isEmpty) {
        emit(SortirError('Gagal mengklasifikasi gambar'));
        return;
      }

      // Get the top result
      final topResult = recognitions.first;
      final label = topResult['label'] as String;
      final confidence = topResult['confidence'] as double;

      final result = SortirModel(
        label: label,
        confidence: confidence,
        image: image,
      );

      emit(SortirClassified(result));
    } catch (e) {
      emit(SortirError('Error saat klasifikasi: $e'));
    }
  }

  void reset() {
    emit(SortirModelLoaded());
  }

  @override
  Future<void> close() {
    _sortirService.closeModel();
    return super.close();
  }
}
