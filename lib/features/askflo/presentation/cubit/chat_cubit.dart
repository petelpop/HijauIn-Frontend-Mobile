import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/models/chat_message.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/repositories/chat_repository.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatCubit(this._repository) : super(const ChatState());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      status: ChatStatus.loading,
    ));

    final aiMessage = await _repository.sendMessage(message);

    emit(state.copyWith(
      messages: [...state.messages, aiMessage],
      status: ChatStatus.success,
    ));
  }

  void resetChat() {
    _repository.resetChat();
    emit(const ChatState());
  }

  void initializeWithMessage(String initialMessage) async {
    if (initialMessage.trim().isEmpty) return;
    await sendMessage(initialMessage);
  }
}
