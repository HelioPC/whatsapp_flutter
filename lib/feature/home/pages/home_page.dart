import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.greenLight,
        centerTitle: true,
        title: const Text('Whatsapp flutter'),
      ),
      body: const Center(
        child: Text('User authenticated'),
      ),
    );
  }
}
