import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_box/model/contact_entity.dart';
import 'package:object_box/services/object_box_contact_services.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_provider.g.dart';

@riverpod
class Contact extends _$Contact {
  @override
  List<ContactEntity> build() {
    return ObjectBox.contactBox.getAll();
  }

  void addContact(ContactEntity user) {
    ObjectBox.contactBox.put(user);
    state = ObjectBox.contactBox.getAll();
  }

  void removeContact(int id) {
    ObjectBox.contactBox.remove(id);
    state = ObjectBox.contactBox.getAll();
  }
}
