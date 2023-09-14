import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contactSource,
    required this.onTap,
  });

  final UserModel contactSource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(
        top: 0,
        right: 10,
        bottom: 0,
        left: 20,
      ),
      dense: true,
      leading: CircleAvatar(
        backgroundColor: context.theme.greyColor?.withOpacity(.3),
        backgroundImage: contactSource.profileImageUrl.isNotEmpty
            ? NetworkImage(contactSource.profileImageUrl)
            : null,
        radius: 20,
        child: contactSource.profileImageUrl.isEmpty
            ? const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              )
            : null,
      ),
      trailing: contactSource.profileImageUrl.isEmpty
          ? TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: MyColors.greenDark,
              ),
              child: const Text('INVITE'),
            )
          : null,
      title: Text(
        contactSource.username,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: contactSource.profileImageUrl.isEmpty
          ? null
          : Text(
              'Hey there! I\'m using WhatsApp',
              style: TextStyle(
                color: context.theme.greyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
