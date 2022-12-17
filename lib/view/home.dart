import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/contact_book_bloc.dart';
import 'package:flutter_bloc/bloc/contact_book_events.dart';
import 'package:flutter_bloc/bloc/contact_book_states.dart';
import 'package:flutter_bloc/view/new_contact.dart';

import '../model/contact.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final ContactBookBloc contactBookBloc;

  @override
  void initState() {
    super.initState();
    contactBookBloc = ContactBookBloc();
    contactBookBloc.inputContactBook.add(LoadContactBookEvent());
  }

  @override
  void dispose() {
    contactBookBloc.inputContactBook.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de contatos"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewContactBook(
                              contactBookBloc: contactBookBloc,
                            )));
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: StreamBuilder<ContactBookState>(
          stream: contactBookBloc.outputContactBook,
          builder: ((_, snapshot) {
            final List<Contact> contacts = snapshot.data?.contacts ?? [];
            return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: ((_, index) {
                  return ListTile(
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].phone),
                    trailing: IconButton(
                        onPressed: () {
                          contactBookBloc.inputContactBook.add(
                              RemoveContactBoookEvent(
                                  contact: contacts[index]));
                        },
                        icon: const Icon(Icons.remove)),
                  );
                }));
          })),
    );
  }
}
