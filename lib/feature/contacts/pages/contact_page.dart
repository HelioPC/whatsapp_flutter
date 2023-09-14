import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/contacts/controllers/contacts_controller.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  Future<void> shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
      'sms:$phoneNumber?Let\'s chat on WhatsApp! it\'s fast, simple and secure app we can call each other for free. Get it at http://whatsappme.com/d1/',
    );

    if (await launchUrl(sms)) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select contacts'),
            const SizedBox(height: 3),
            ref.watch(contactControllerProvider).when(
              data: (contacts) {
                final count = contacts[0].length;
                return Text('$count Contact${count == 1 ? '' : 's'}');
              },
              error: (e, t) {
                return const SizedBox();
              },
              loading: () {
                return const Text('Counting...');
              },
            ),
          ],
        ),
        actions: [
          CustomIconButton(onTap: () {}, iconData: Icons.search),
          CustomIconButton(onTap: () {}, iconData: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerProvider).when(data: (contacts) {
        return ListView.builder(
          itemCount: contacts[0].length + contacts[1].length,
          itemBuilder: (context, i) {
            late UserModel firebaseContacts;
            late UserModel phoneContacts;

            if (i < contacts[0].length) {
              firebaseContacts = contacts[0][i];
            } else {
              phoneContacts = contacts[1][i - contacts[0].length];
            }

            return i < contacts[0].length
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (i == 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Contacts on WhatsApp',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: context.theme.greyColor,
                            ),
                          ),
                        )
                      ],
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          top: 0,
                          right: 10,
                          bottom: 0,
                          left: 20,
                        ),
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor:
                              context.theme.greyColor?.withOpacity(.3),
                          backgroundImage: firebaseContacts
                                  .profileImageUrl.isNotEmpty
                              ? NetworkImage(firebaseContacts.profileImageUrl)
                              : null,
                          radius: 20,
                          child: firebaseContacts.profileImageUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        title: Text(
                          firebaseContacts.username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          'Hey there! I\'m using WhatsApp',
                          style: TextStyle(
                            color: context.theme.greyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      if (i == 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Contacts on WhatsApp',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: context.theme.greyColor,
                            ),
                          ),
                        )
                      ],
                      ListTile(
                        onTap: () async => shareSmsLink(
                          phoneContacts.phoneNumber,
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 0,
                          right: 10,
                          bottom: 0,
                          left: 20,
                        ),
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor:
                              context.theme.greyColor?.withOpacity(.3),
                          radius: 20,
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: () async => shareSmsLink(
                            phoneContacts.phoneNumber,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: MyColors.greenDark,
                          ),
                          child: const Text('INVITE'),
                        ),
                        title: Text(
                          phoneContacts.username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          'Hey there! I\'m using WhatsApp',
                          style: TextStyle(
                            color: context.theme.greyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  );
          },
        );
      }, error: (error, trace) {
        return const Center(
          child: Text('Something went wrong'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(color: MyColors.greenDark),
        );
      }),
    );
  }
}
