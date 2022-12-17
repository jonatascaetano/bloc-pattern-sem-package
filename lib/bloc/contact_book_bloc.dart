import 'dart:async';

import 'package:flutter_bloc/bloc/contact_book_events.dart';
import 'package:flutter_bloc/bloc/contact_book_states.dart';
import 'package:flutter_bloc/repository/contact_book_repository.dart';

import '../model/contact.dart';

class ContactBookBloc {
  final _contactBookRepository = ContactBookRepository();

  final StreamController<ContactBookEvent> _inputContactBookController =
      StreamController<ContactBookEvent>();
  final StreamController<ContactBookState> _outputContactBookController =
      StreamController<ContactBookState>();

  Sink<ContactBookEvent> get inputContactBook =>
      _inputContactBookController.sink;
  Stream<ContactBookState> get outputContactBook =>
      _outputContactBookController.stream;

  ContactBookBloc() {
    _inputContactBookController.stream.listen((ContactBookEvent event) {
      List<Contact> contacts = [];
      if (event is LoadContactBookEvent) {
        contacts = _contactBookRepository.loadContact();
      } else if (event is AddContactBookEvent) {
        contacts = _contactBookRepository.addContact(contact: event.contact);
      } else if (event is RemoveContactBoookEvent) {
        contacts = _contactBookRepository.removeContact(contact: event.contact);
      }
      return _outputContactBookController
          .add(ContactBookSucessState(contacts: contacts));
    });
  }
}
