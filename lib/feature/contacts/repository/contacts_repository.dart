import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';

final contactsRepositoryProvider = Provider((ref) {
  return ContactsRepository(firestore: FirebaseFirestore.instance);
});

class ContactsRepository {
  final FirebaseFirestore firestore;

  ContactsRepository({required this.firestore});

  Future<List<List>> getAllContacts() async {
    // Contacts saved in user phone and have an account
    List<UserModel> firebaseContacts = [];
    // Contacts saved in user phone and doesn't have an account
    List<UserModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allPhoneContacts = await FlutterContacts.getContacts(
          withProperties: true,
        );

        bool isContactFound = false;

        for (var contact in allPhoneContacts) {
          for (var fContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(fContactData.data());

            if (contact.phones[0].number.replaceAll(' ', '') ==
                firebaseContact.phoneNumber) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }

          if (!isContactFound) {
            phoneContacts.add(UserModel(
              username: contact.displayName,
              uid: 'uid',
              profileImageUrl: '',
              active: false,
              phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
              groupId: [],
            ));
          }
          isContactFound = false;
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return [firebaseContacts, phoneContacts];
  }
}
