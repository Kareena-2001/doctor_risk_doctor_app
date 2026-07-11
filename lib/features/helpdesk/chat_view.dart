import 'package:Doctors_App/features/helpdesk/ui/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/dimensions.dart';
import '../../core/constants/values/app_text_style.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../common/ui/widgets/loading.dart';

class ChatView extends ConsumerWidget {
  ChatView({super.key});

  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatViewModelProvider);
    final chatVM = ref.read(chatViewModelProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(title: 'AI Assistant'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: chatState.messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: chatState.messages.length,
                      itemBuilder: (context, index) {
                        final msg = chatState.messages[index];
                        return _buildMessageBubble(
                          message: msg.text,
                          isUser: msg.role == 'user',
                        );
                      },
                    ),
            ),
            if (chatState.isLoading)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Loading(),
                    SizedBox(width: 12),
                    Text("AI is typing..."),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputController,
                        style: AppTheme.label14,
                        decoration: InputDecoration(
                          hintText: "Ask me anything...",
                          hintStyle: AppTheme.label14,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.lightGray,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          prefixIcon: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    width(8),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          final text = inputController.text.trim();
                          if (text.isNotEmpty) {
                            chatVM.sendMessage(text);
                            inputController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey.shade300,
          ),
          height(20),
          Text(
            "Start a conversation",
            style: customTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          height(8),
          Text(
            "Ask me anything about your sales,\nperformance, or get help!",
            textAlign: TextAlign.center,
            style: customTextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          height(30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _buildSuggestionChip("What's my sales performance?"),
              _buildSuggestionChip("Show my pipeline status"),
              _buildSuggestionChip("How do I add a customer?"),
              _buildSuggestionChip("Explain my reports"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        inputController.text = text;
      },
      backgroundColor: AppColors.primary,
      labelStyle: customTextStyle(color: AppColors.white, fontSize: 12),
    );
  }

  Widget _buildMessageBubble({required String message, required bool isUser}) {
    debugPrint(message);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.smart_toy,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            width(8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: customTextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 15,
                ).copyWith(height: 1.4),
              ),
            ),
          ),
          if (isUser) ...[
            width(8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.person, size: 20, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
