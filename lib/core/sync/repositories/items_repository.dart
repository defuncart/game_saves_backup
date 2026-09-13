import 'package:game_saves_backup/core/sync/models/backup_item.dart';
import 'package:game_saves_backup/core/sync/repositories/hive_registrar.g.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce/hive_ce.dart';

part 'items_repository.g.dart';

@GenerateAdapters([AdapterSpec<BackupItem>()])
abstract class ItemsRepository {
  Iterable<BackupItem> getAllItems();
  void addItem(BackupItem item);
  void removeItem(String id);
}

class HiveItemsRepository extends ItemsRepository {
  late final Box<BackupItem> _box;
  static const _name = 'items';

  HiveItemsRepository() {
    _box = Hive.box<BackupItem>(_name);
  }

  static Future<void> init() async {
    Hive.registerAdapters();
    await Hive.openBox<BackupItem>(_name);
  }

  @override
  Iterable<BackupItem> getAllItems() => _box.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  @override
  void addItem(BackupItem item) => _box.put(item.id, item);

  @override
  void removeItem(String id) => _box.delete(id);
}
