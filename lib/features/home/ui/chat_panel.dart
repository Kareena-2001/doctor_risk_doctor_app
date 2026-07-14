import 'package:Doctors_App/features/home/ui/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../model/chat_message_model.dart';

class ChatPanel extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const ChatPanel({super.key, required this.onClose});

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSend() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    ref.read(chatViewModelProvider.notifier).sendMessage(text);
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatViewModelProvider);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: Responsive.w(320),
        height: Responsive.h(440),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.w(22)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(14),
                  vertical: Responsive.h(10),
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    _buildBubble(messages[index]),
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(16),
        vertical: Responsive.h(14),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.newPri, AppColors.primary],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.support_agent, color: Colors.white, size: Responsive.sp(20)),
          width(Responsive.w(8)),
          Expanded(
            child: Text(
              'Chat with us',
              style: customTextStyle(
                color: Colors.white,
                fontSize: Responsive.sp(15),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: widget.onClose,
            borderRadius: BorderRadius.circular(Responsive.w(20)),
            child: Padding(
              padding: EdgeInsets.all(Responsive.w(4)),
              child: Icon(Icons.close, color: Colors.white, size: Responsive.sp(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMessageModel message) {
    final isUser = message.sender == ChatSender.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Responsive.h(5)),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(14),
          vertical: Responsive.h(10),
        ),
        constraints: BoxConstraints(maxWidth: Responsive.w(220)),
        decoration: BoxDecoration(
          color: isUser ? AppColors.newPri : const Color(0xFFF1F1F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Responsive.w(14)),
            topRight: Radius.circular(Responsive.w(14)),
            bottomLeft: Radius.circular(isUser ? Responsive.w(14) : 0),
            bottomRight: Radius.circular(isUser ? 0 : Responsive.w(14)),
          ),
        ),
        child: Text(
          message.text,
          style: customTextStyle(
            color: isUser ? Colors.white : AppColors.textColor,
            fontSize: Responsive.sp(12.5),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12),
        vertical: Responsive.h(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _handleSend(),
              textInputAction: TextInputAction.send,
              style: customTextStyle(fontSize: Responsive.sp(13)),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: customTextStyle(
                  fontSize: Responsive.sp(13),
                  color: Colors.grey.shade500,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F8),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(14),
                  vertical: Responsive.h(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          width(Responsive.w(8)),
          InkWell(
            onTap: _handleSend,
            borderRadius: BorderRadius.circular(Responsive.w(24)),
            child: Container(
              padding: EdgeInsets.all(Responsive.w(10)),
              decoration: BoxDecoration(
                color: AppColors.newPri,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send_rounded, color: Colors.white, size: Responsive.sp(18)),
            ),
          ),
        ],
      ),
    );
  }
}