import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/feature/contacts/repository/contacts_repository.dart';

final contactControllerProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(contactsRepositoryProvider);

  return contactRepository.getAllContacts();
});
