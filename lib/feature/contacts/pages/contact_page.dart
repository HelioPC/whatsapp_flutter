import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/contacts/controllers/contacts_controller.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select contacts'),
            SizedBox(
              height: 3,
            ),
            Text(
              '5 contacts',
              style: TextStyle(fontSize: 12),
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
          itemCount: contacts[1].length,
          itemBuilder: (context, i) {
            return Card(
              child: Text(contacts[1][i].username),
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
