import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_box/controller/contact_provider.dart';
import 'package:object_box/model/contact_entity.dart';

class ContactApp extends ConsumerWidget {
  ContactApp({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = ref.watch(contactProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ContactApp"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text(contactList[index].name),
                subtitle: Text(contactList[index].phonenumber),
                trailing: IconButton(
                    onPressed: () {
                      ref
                          .read(contactProvider.notifier)
                          .removeContact(contactList[index].id);
                    },
                    icon: Icon(Icons.delete)),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: contactList.length),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addDialog(context, ref);
          },
          label: Text("Add item")),
    );
  }

  Future<dynamic> addDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(contactProvider.notifier).addContact(
                          ContactEntity(
                              name: _nameController.text,
                              phonenumber: _phoneController.text));
                      Navigator.pop(context);
                      _nameController.clear();
                      _phoneController.clear();
                    },
                    child: Text("Add")),
                ElevatedButton(
                    onPressed: () {
                      _nameController.clear();
                      _phoneController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("cancel"))
              ],
            ));
  }
}
