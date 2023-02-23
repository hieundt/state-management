import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String id;
  final String name;
  Contact({
    required this.name,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  //* Singleton pattern
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  //final List<Contact> _contacts = [];

  //* We're extended ValueNotifier with a type of List<Contact>
  //* So the 'value' itself is of type List<Contact>
  int get length => value.length;

  void add({required Contact contact}) {
    //*  implicit way
    // value.add(contact);
    // notifyListeners();

    //*  explicit way
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
    }
  }

  Contact? getContact({required int atIndex}) {
    return value.length > atIndex ? value[atIndex] : null;
  }
}
