import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';

class ChatPage extends ConsumerWidget {
  final UserModel userModel;

  const ChatPage({super.key, required this.userModel});

  String lastSeenMessage(lastSeen) {
    DateTime now = DateTime.now();
    Duration differenceDuration = now.difference(
      DateTime.fromMillisecondsSinceEpoch(lastSeen),
    );

    return differenceDuration.inSeconds > 59
        ? differenceDuration.inMinutes > 59
            ? differenceDuration.inHours > 23
                ? '${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}'
                : '${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}'
            : '${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}'
        : 'few moments';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            StreamBuilder(
              stream: ref
                  .read(authControllerProvider)
                  .getUserPresenceStatus(uid: userModel.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return const Text(
                    'Connecting...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  );
                }

                final singleUserModel = snapshot.data!;
                final lastMessage = lastSeenMessage(singleUserModel.lastSeen);

                return Text(
                  singleUserModel.active ? 'active' : '$lastMessage ago',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                );
              },
            )
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
