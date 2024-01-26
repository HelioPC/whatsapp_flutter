import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:whatsapp_flutter/common/enum/message_type.dart'
    as my_message_type;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/models/message_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSender,
    required this.haveNip,
    required this.message,
  });

  final bool isSender;
  final bool haveNip;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
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
                isSender ? MessageType.send : MessageType.receive,
                nipWidth: 8,
                nipHeight: 10,
                bubbleRadius: haveNip ? 12 : 0,
              )
            : null,
        child: Stack(
          children: [
            Container(
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
                borderRadius: haveNip ? null : BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black38)],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: message.type == my_message_type.MessageType.image
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 5,
                          right: 5,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image:
                                CachedNetworkImageProvider(message.textMessage),
                          ),
                        ),
                      )
                    : Text(
                        '${message.textMessage}            ',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            Positioned(
              bottom: message.type == my_message_type.MessageType.image ? 8 : 4,
              right: message.type == my_message_type.MessageType.image
                  ? isSender
                      ? 15
                      : 10
                  : 4,
              child: message.type == my_message_type.MessageType.image
                  ? Text(
                      DateFormat.Hm().format(message.timeSent),
                      style: TextStyle(
                        fontSize: 11,
                        color: context.theme.greyColor,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        left: 90,
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.theme.greyColor!.withOpacity(0),
                            context.theme.greyColor!.withOpacity(.5),
                          ],
                          begin: const Alignment(0, -1),
                          end: const Alignment(1, 1),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(300),
                        ),
                        boxShadow: const [BoxShadow(color: Colors.black38)],
                      ),
                      child: Text(
                        DateFormat.Hm().format(message.timeSent),
                        style: TextStyle(
                          fontSize: 11,
                          color: context.theme.greyColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
