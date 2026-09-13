import 'dart:convert';
import 'dart:io';

import 'package:game_saves_backup/core/sync/models/backup_item.dart';
import 'package:game_saves_backup/core/sync/repositories/items_repository.dart';
import 'package:path/path.dart' as p;

/// Imports a previously exported db
Future<void> isarJsonHiveImportMigration(String defaultDirectory) async {
  if (await Directory(defaultDirectory).exists()) {
    final file = File(p.join(defaultDirectory, 'export.json'));
    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        final items = (json as List<dynamic>).map((e) => BackupItem.fromJson(e));

        // assumed already initialized
        final repo = HiveItemsRepository();
        if (repo.getAllItems().isEmpty) {
          for (final (index, item) in items.indexed) {
            final effectiveItem = BackupItem(
              id: BackupItem.createIndex(index), // use as new id
              path: item.path,
              folderName: item.folderName,
            );
            repo.addItem(effectiveItem);
          }
        }
      } catch (_) {}
    }
  }
}
