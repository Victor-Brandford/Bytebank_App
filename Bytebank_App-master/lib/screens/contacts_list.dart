import 'package:bytebank_salvamento_arquivos/components/progress.dart';
import 'package:bytebank_salvamento_arquivos/models/contact.dart';
import 'package:bytebank_salvamento_arquivos/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank_salvamento_arquivos/database/dao/contact_dao.dart';
import 'contact_form.dart';

class  ContactsList extends StatefulWidget {
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final Contact_DAO _dao = Contact_DAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts![index];
                  return _ContatcItem(
                    contact,
                    onclick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
                itemCount: contacts!.length,
              );
          }

          return Text('Unknown Error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactForm(),
          )).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}

class _ContatcItem extends StatelessWidget {
  final Contact contact;
  final Function onclick;

  _ContatcItem(this.contact, {
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          onclick();
        },
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
