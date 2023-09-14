import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;

  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.adaptive.arrow_back),
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(userModel.profileImageUrl),
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Text(
              userModel.username,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 3),
            const Text('last seen 2 min ago'),
          ],
        ),
        actions: [
          CustomIconButton(onTap: () {}, iconData: Icons.video_call),
          CustomIconButton(onTap: () {}, iconData: Icons.call),
          CustomIconButton(onTap: () {}, iconData: Icons.more_vert),
        ],
      ),
    );
  }
}
