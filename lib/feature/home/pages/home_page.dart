import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/home/pages/call_home_page.dart';
import 'package:whatsapp_flutter/feature/home/pages/chat_home_page.dart';
import 'package:whatsapp_flutter/feature/home/pages/status_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Whatsapp',
            style: TextStyle(letterSpacing: 1),
          ),
          actions: [
            CustomIconButton(
              onTap: () {},
              iconData: Icons.search,
            ),
            CustomIconButton(
              onTap: () {},
              iconData: Icons.more_vert,
            ),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatHomePage(),
            StatusHomePage(),
            CallHomePage(),
          ],
        ),
      ),
    );
  }
}
