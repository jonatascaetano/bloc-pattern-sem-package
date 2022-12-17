import 'package:flutter/material.dart';
import 'package:flutter_bloc/bloc/contact_book_bloc.dart';
import 'package:flutter_bloc/bloc/contact_book_events.dart';
import 'package:flutter_bloc/model/contact.dart';

class NewContactBook extends StatefulWidget {
  final ContactBookBloc contactBookBloc;
  const NewContactBook({super.key, required this.contactBookBloc});

  @override
  State<NewContactBook> createState() => _NewContactBookState();
}

class _NewContactBookState extends State<NewContactBook> {
  final key = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo contato"),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("nome")),
                controller: name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "insira o nome do contato";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("telefone")),
                controller: phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "insira o telefone do contato";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      widget.contactBookBloc.inputContactBook.add(
                        AddContactBookEvent(
                          contact: Contact(name: name.text, phone: phone.text),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("salvar")),
            ],
          ),
        ),
      ),
    );
  }
}
