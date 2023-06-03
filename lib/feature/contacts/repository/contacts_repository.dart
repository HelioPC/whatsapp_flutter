import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_flutter/common/models/user_model.dart';

class ContactsRepository {
  final FirebaseFirestore firestore;

  ContactsRepository({required this.firestore});

  /*Future<List<List>> getAllContacts() async {
    // Contacts saved in user phone and have an account
    List<UserModel> firebaseContacts = [];
    // Contacts saved in user phone and doesn't have an account
    List<UserModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allPhoneContacts =
            await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {}
  }*/
}
