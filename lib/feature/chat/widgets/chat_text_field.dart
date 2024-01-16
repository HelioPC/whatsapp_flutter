import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/chat/controllers/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key, required this.receiverId});

  final String receiverId;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  late TextEditingController messageController;
  bool isMessageIconEnabled = false;

  void sendTextMessage() async {
    if (isMessageIconEnabled) {
      ref.read(chatControllerProvider).sendTextMessage(
            context: context,
            textMessage: messageController.text,
            receiverId: widget.receiverId,
          );
      messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: messageController,
            maxLines: 4,
            minLines: 1,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            onChanged: (value) {
              value.isEmpty
                  ? setState(() => isMessageIconEnabled = false)
                  : setState(() => isMessageIconEnabled = true);
            },
            decoration: InputDecoration(
              hintText: 'Message',
              hintStyle: TextStyle(color: context.theme.greyColor),
              filled: true,
              fillColor: context.theme.chatTextFieldBg,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: Material(
                color: Colors.transparent,
                child: CustomIconButton(
                  onTap: () {},
                  iconData: Icons.emoji_emotions_outlined,
                  color: Theme.of(context).listTileTheme.iconColor,
                ),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotatedBox(
                    quarterTurns: 45,
                    child: CustomIconButton(
                      onTap: () {},
                      iconData: Icons.attach_file,
                      color: Theme.of(context).listTileTheme.iconColor,
                    ),
                  ),
                  CustomIconButton(
                    onTap: () {},
                    iconData: Icons.camera_alt_outlined,
                    color: Theme.of(context).listTileTheme.iconColor,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        CustomIconButton(
          onTap: sendTextMessage,
          iconData: isMessageIconEnabled
              ? Icons.send_outlined
              : Icons.mic_none_outlined,
          background: MyColors.greenDark,
          color: Colors.white,
        )
      ],
    );
  }
}
