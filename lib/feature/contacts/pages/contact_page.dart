import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/contacts/controllers/contacts_controller.dart';
import 'package:whatsapp_flutter/feature/contacts/widgets/contact_card.dart';

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
                        Column(
                          children: [
                            myListTile(leading: Icons.group, text: 'New group'),
                            myListTile(
                              leading: Icons.contacts,
                              text: 'New contact',
                              trailing: Icons.qr_code,
                            ),
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
                            ),
                          ],
                        )
                      ],
                      ContactCard(
                        onTap: () {},
                        contactSource: firebaseContacts,
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
                      ContactCard(
                        onTap: () => shareSmsLink(
                          phoneContacts.phoneNumber,
                        ),
                        contactSource: phoneContacts,
                      ),
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

ListTile myListTile({
  required IconData leading,
  required String text,
  IconData? trailing,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
    leading: CircleAvatar(
      radius: 20,
      backgroundColor: MyColors.greenDark,
      child: Icon(
        leading,
        color: Colors.white,
      ),
    ),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: Icon(
      trailing,
      color: MyColors.greyDark,
    ),
  );
}
