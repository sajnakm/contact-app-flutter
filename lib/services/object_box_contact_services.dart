import 'package:object_box/model/contact_entity.dart';
import 'package:object_box/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;
  static late final Box<ContactEntity> contactBox;
  ObjectBox._create(this.store) {
    contactBox = store.box<ContactEntity>();
  }
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store = await openStore(
      directory: join(
        docsDir.path,
        "contactBox",
      ),
    );
    return ObjectBox._create(store);
  }
}
