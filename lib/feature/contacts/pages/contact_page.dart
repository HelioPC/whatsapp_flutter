import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
