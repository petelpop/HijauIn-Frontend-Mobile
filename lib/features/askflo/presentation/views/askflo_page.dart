import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/askflo/presentation/components/quick_action_button.dart';
import 'package:sizer/sizer.dart';

class AskfloPage extends StatefulWidget {
  static const String routeName = "askflo-page";
  const AskfloPage({super.key});

  @override
  State<AskfloPage> createState() => _AskfloPageState();
}

class _AskfloPageState extends State<AskfloPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _navigateToChat(String initialMessage) {
    if (initialMessage.trim().isEmpty) return;
    // TODO: Navigate to chat page with initial message
    // context.push('/askflo/chat', extra: initialMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.imgBgAskflo))
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
            
                  Image.asset(
                    Constants.icChatbotAskflo,
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 3.h),
            
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi, Hani',
                          style: TextStyle(
                            color: colorTextDarkPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: '👋',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
            
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Aku ',
                          style: TextStyle(
                            color: colorTextDarkPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: 'Askflo',
                          style: TextStyle(
                            color: primaryColor600,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: '!',
                          style: TextStyle(
                            color: colorTextDarkPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
            
                  PrimaryText(
                    text:
                        'Bolehkah aku membantumu untuk bersama-sama menjaga bumi?',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colorTextDarkSecondary,
                    textAlign: TextAlign.left,
                    lineHeight: 1.5,
                  ),
                  SizedBox(height: 5.h),
            
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: primaryColor600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 2.w),
                            PrimaryText(
                              text: 'Tanya Askflo',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
            
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFFE5E7EB),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _messageController,
                                        onSubmitted: (value) {
                                          _navigateToChat(value);
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Tanya sesuatu...',
                                          hintStyle: TextStyle(
                                            color: colorTextDarkSecondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                            vertical: 1.5.h,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                        maxLines: 3,
                                        minLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          _navigateToChat(_messageController.text);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2.w),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF9CA3AF),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.send,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.h),
            
                              //TODO: Quick Action Buttons
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 2.w,
                                runSpacing: 1.h,
                                children: [
                                  QuickActionButton(
                                    text: 'Mengelola sampah organik',
                                    onTap: () => _navigateToChat('Mengelola sampah organik'),
                                  ),
                                  QuickActionButton(
                                    text: 'Apa itu AQI',
                                    onTap: () => _navigateToChat('Apa itu AQI'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}