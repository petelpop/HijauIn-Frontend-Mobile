import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/datasources/gemini_data_source.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/models/chat_message.dart';
import 'package:hijauin_frontend_mobile/features/askflo/data/repositories/chat_repository.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/cubit/chat_cubit.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/cubit/chat_state.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = "chat-page";
  final String? initialMessage;

  const ChatPage({super.key, this.initialMessage});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage(ChatCubit cubit) {
    if (_messageController.text.trim().isEmpty) return;
    cubit.sendMessage(_messageController.text);
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ChatCubit(ChatRepository(GeminiDataSource()));
        if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
          cubit.initializeWithMessage(widget.initialMessage!);
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorTextDarkPrimary),
            onPressed: () => context.pop(),
          ),
          centerTitle: true,
          title: Row(
            children: [
              Image.asset(
                Constants.icChatbotAskflo,
                width: 8.w,
              ),
              SizedBox(width: 1.w,),
              PrimaryText(
                text: 'Askflo',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorTextDarkPrimary,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Color(0x19030712),
              height: 1.0,
            ),
          ),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(4.w),
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            return _buildMessageBubble(message);
                          },
                        ),
                ),
                if (state.status == ChatStatus.loading)
                  _buildTypingIndicator(),
                _buildMessageInput(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco,
              size: 80,
              color: primaryColor600,
            ),
            SizedBox(height: 3.h),
            PrimaryText(
              text: 'Hai! Aku Askflo 🌿',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorTextDarkPrimary,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            PrimaryText(
              text:
                  'Tanyakan apa saja tentang alam, lingkungan, flora, fauna, ekosistem, dan segala hal tentang bumi kita!',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colorTextDarkSecondary,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.role == MessageRole.user;
    final time = DateFormat('HH:mm').format(message.timestamp);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  Constants.icAskfloProfile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 2.w),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: message.isError 
                        ? Colors.red.shade50
                        : (isUser ? Color(0xFFF3FAF8) : Color(0xFF2D746A)),
                    border: message.isError 
                        ? Border.all(color: Colors.red.shade300, width: 1)
                        : null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: isUser ? Radius.circular(16) : Radius.circular(4),
                      bottomRight: isUser ? Radius.circular(4) : Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.isError)
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 16),
                              SizedBox(width: 1.w),
                              PrimaryText(
                                text: 'Error',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      if (isUser)
                        PrimaryText(
                          text: message.content,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2D746A),
                          textAlign: TextAlign.left,
                          lineHeight: 1.5,
                        )
                      else
                        MarkdownBody(
                          data: message.content,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: message.isError 
                                  ? Colors.red.shade900
                                  : whiteColor,
                              fontFamily: 'Poppins',
                              height: 1.5,
                            ),
                            h1: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                            h2: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                            h3: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                            strong: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: whiteColor,
                            ),
                            em: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: whiteColor,
                            ),
                            listBullet: TextStyle(
                              fontSize: 14,
                              color: whiteColor,
                            ),
                            code: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              backgroundColor: Colors.white.withOpacity(0.1),
                              color: whiteColor,
                            ),
                            codeblockDecoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            blockquote: TextStyle(
                              fontSize: 14,
                              color: whiteColor.withOpacity(0.9),
                              fontStyle: FontStyle.italic,
                            ),
                            blockquoteDecoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: whiteColor.withOpacity(0.5),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 0.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: PrimaryText(
                    text: time,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: colorTextDarkSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                Constants.icAskfloProfile,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                SizedBox(width: 1.w),
                _buildTypingDot(1),
                SizedBox(width: 1.w),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final opacity = ((value + delay) % 1.0) > 0.5 ? 1.0 : 0.3;
        return Opacity(
          opacity: opacity,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: primaryColor600,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan...',
                    hintStyle: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.5.h,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 4,
                  minLines: 1,
                  onSubmitted: (_) => _sendMessage(cubit),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () => _sendMessage(cubit),
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: primaryColor600,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
