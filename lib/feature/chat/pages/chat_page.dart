import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/helpers/last_seen_message.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/common/routes/routes.dart';
import 'package:whatsapp_flutter/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/chat/controllers/chat_controller.dart';
import 'package:whatsapp_flutter/feature/chat/widgets/chat_text_field.dart';

class ChatPage extends ConsumerWidget {
  final UserModel userModel;

  ChatPage({super.key, required this.userModel});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.chatPageBgColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.adaptive.arrow_back),
              Hero(
                tag: 'profile',
                child: Container(
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        userModel.profileImageUrl,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.profile, arguments: userModel);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    final lastMessage =
                        lastSeenMessage(singleUserModel.lastSeen);

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
          ),
        ),
        actions: [
          CustomIconButton(onTap: () {}, iconData: Icons.video_call),
          CustomIconButton(onTap: () {}, iconData: Icons.call),
          CustomIconButton(onTap: () {}, iconData: Icons.more_vert),
        ],
      ),
      body: Stack(
        children: [
          Image(
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
            color: context.theme.chatPageBgColor,
            image: const AssetImage(
              'assets/images/doodle_bg.png',
            ),
          ),
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ref
                      .read(chatControllerProvider)
                      .getAllOneToOneMessage(userModel.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final messages = snapshot.data;

                    return ListView.builder(
                      itemCount: messages!.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        final message = messages[index];
                        final isSender = message.senderId ==
                            FirebaseAuth.instance.currentUser!.uid;

                        final haveNip = (index == 0) ||
                            (index == messages.length - 1 &&
                                message.senderId !=
                                    messages[index - 1].senderId) ||
                            (message.senderId != messages[index - 1].senderId &&
                                message.senderId ==
                                    messages[index + 1].senderId) ||
                            (message.senderId != messages[index - 1].senderId &&
                                message.senderId !=
                                    messages[index + 1].senderId);

                        return Column(
                          children: [
                            if (index == 0)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 30,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: context.theme.yellowCardBgColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Messages and calls are end-to-end encrypted. No one outside of this chat, not even WhatsApp, can read or listen to them. Tap to learn more.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: context.theme.yelloCardTextColor,
                                  ),
                                ),
                              ),
                            Container(
                              alignment: isSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                                left: isSender
                                    ? 80
                                    : haveNip
                                        ? 10
                                        : 15,
                                right: isSender
                                    ? haveNip
                                        ? 10
                                        : 15
                                    : 80,
                              ),
                              child: ClipPath(
                                clipper: haveNip
                                    ? UpperNipMessageClipperTwo(
                                        isSender
                                            ? MessageType.send
                                            : MessageType.receive,
                                        nipWidth: 8,
                                        nipHeight: 10,
                                        bubbleRadius: haveNip ? 12 : 0,
                                      )
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: isSender ? 10 : 15,
                                    right: isSender ? 15 : 10,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? context.theme.senderChatCardBg
                                        : context.theme.receiverChatCardBg,
                                    borderRadius: haveNip
                                        ? null
                                        : BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black38)
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          '${message.textMessage}            ',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Text(
                                          DateFormat.Hm()
                                              .format(message.timeSent),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: context.theme.greyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              ChatTextField(
                receiverId: userModel.uid,
                scrollController: _scrollController,
              ),
            ],
          )
        ],
      ),
    );
  }
}
