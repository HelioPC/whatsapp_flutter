import 'package:whatsapp_flutter/common/enum/message_type.dart';

class MessageModel {
  final String receiverId;
  final String senderId;
  final String textMessage;
  final MessageType type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  MessageModel({
    required this.receiverId,
    required this.senderId,
    required this.textMessage,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      textMessage: map['textMessage'],
      type: map['type'].toString().toEnum(),
      timeSent: DateTime.parse(map['timeSent']),
      messageId: map['messageId'],
      isSeen: map['isSeen'].toString().toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'textMessage': textMessage,
      'type': type.type,
      'timeSent': timeSent.toIso8601String(),
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }
}
