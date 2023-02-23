import 'package:flutter/material.dart';
import 'package:state_management/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          //* This is a explicit way
          //* 'value' itself is a List<Contact>
          //* final contacts = value as List<Contact>
          return ListView.builder(
            itemCount: value.length, //* contacts.length
            itemBuilder: (context, index) {
              //* final contacts = contacts[index]
              final contact = value[index];
              return Dismissible(
                onDismissed: (direction) {
                  ContactBook().remove(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/new-contact');
        },
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new contact',
            ),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact: contact);
              Navigator.of(context).pop();
            },
            child: const Text('Add contact'),
          ),
        ],
      ),
    );
  }
}
