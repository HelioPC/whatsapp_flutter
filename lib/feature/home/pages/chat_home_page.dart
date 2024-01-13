import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/models/last_message_model.dart';
import 'package:whatsapp_flutter/common/routes/routes.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/chat/controllers/chat_controller.dart';

class ChatHomePage extends ConsumerWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder<List<LastMessageModel>>(
        stream: ref.watch(chatControllerProvider).getAllLastMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.greenDark,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final lastMessage = snapshot.data![index];

              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lastMessage.username),
                    Text(
                      DateFormat.Hm().format(lastMessage.timeSent),
                      style: TextStyle(
                        fontSize: 13,
                        color: context.theme.greyColor,
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    lastMessage.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: context.theme.greyColor),
                  ),
                ),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(
                    lastMessage.profileImageUrl,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.contacts),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
