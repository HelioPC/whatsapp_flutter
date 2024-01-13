import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/feature/chat/repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
  }) async {
    ref.read(userInfoAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            textMessage: textMessage,
            receiverId: receiverId,
            senderUserData: value!,
          ),
        );
  }
}
