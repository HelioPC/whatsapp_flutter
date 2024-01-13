import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_flutter/common/enum/message_type.dart';
import 'package:whatsapp_flutter/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp_flutter/common/models/last_message_model.dart';
import 'package:whatsapp_flutter/common/models/message_model.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<LastMessageModel>> getAllLastMessages() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap(
      (event) async {
        final lastMessages = <LastMessageModel>[];
        for (final doc in event.docs) {
          final lastMessage = LastMessageModel.fromMap(doc.data());
          final userData = await firestore
              .collection('users')
              .doc(lastMessage.contactId)
              .get();
          final user = UserModel.fromMap(userData.data()!);
          lastMessages.add(
            LastMessageModel(
              username: user.username,
              profileImageUrl: user.profileImageUrl,
              contactId: lastMessage.contactId,
              timeSent: lastMessage.timeSent,
              lastMessage: lastMessage.lastMessage,
            ),
          );
        }
        return lastMessages;
      },
    );
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
    required UserModel senderUserData,
  }) async {
    try {
      final timeSent = DateTime.now();
      final receiverDataMap =
          await firestore.collection('users').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();

      saveToMessageCollection(
        messageType: MessageType.text,
        receiverId: receiverId,
        textMessage: textMessage,
        timeSent: timeSent,
        textMessageId: textMessageId,
        receiverUsername: receiverData.username,
        senderUsername: senderUserData.username,
      );

      saveAsLastMessage(
        receiverId: receiverId,
        senderUserData: senderUserData,
        receiverUserData: receiverData,
        textMessage: textMessage,
        timeSent: timeSent,
      );
    } catch (e) {
      if (context.mounted) {
        showAlertDialog(context: context, message: e.toString());
      }
    }
  }

  void saveToMessageCollection({
    required String receiverId,
    required String textMessage,
    required DateTime timeSent,
    required String textMessageId,
    required String receiverUsername,
    required String senderUsername,
    required MessageType messageType,
  }) async {
    final message = MessageModel(
      textMessage: textMessage,
      timeSent: timeSent,
      senderId: auth.currentUser!.uid,
      receiverId: receiverId,
      type: messageType,
      messageId: textMessageId,
      isSeen: false,
    );

    // sender
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    // receiver
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String textMessage,
    required DateTime timeSent,
    required String receiverId,
  }) async {
    final receiverLastMessage = LastMessageModel(
      username: senderUserData.username,
      profileImageUrl: senderUserData.profileImageUrl,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
      username: receiverUserData.username,
      profileImageUrl: receiverUserData.profileImageUrl,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }
}
