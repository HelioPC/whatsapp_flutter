import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/enum/message_type.dart';
import 'package:whatsapp_flutter/common/models/last_message_model.dart';
import 'package:whatsapp_flutter/common/models/message_model.dart';
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

  void sendFileMessage({
    required var file,
    required BuildContext context,
    required String receiverId,
    required MessageType messageType,
  }) async {
    ref.read(userInfoAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            file: file,
            context: context,
            receiverId: receiverId,
            senderUserData: value!,
            ref: ref,
            messageType: messageType,
          ),
        );
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return chatRepository.getAllOneToOneMessage(receiverId);
  }

  Stream<List<LastMessageModel>> getAllLastMessages() {
    return chatRepository.getAllLastMessages();
  }

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
