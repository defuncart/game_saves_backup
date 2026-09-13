import 'dart:developer' show log;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_saves_backup/core/sync/migration/isar_json_hive_import_migration.dart';
import 'package:game_saves_backup/core/sync/repositories/items_repository.dart';
import 'package:game_saves_backup/core/sync/repositories/settings_repository.dart';
import 'package:game_saves_backup/core/ui/my_app.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final defaultDirectory = p.join(dir.path, 'game_saves_backup');
  if (!await Directory(defaultDirectory).exists()) {
    await Directory(defaultDirectory).create(recursive: true);
  }
  Hive.init(defaultDirectory);
  log('Hive.defaultDirectory: $defaultDirectory');
  await HiveItemsRepository.init();
  await HiveSyncSettingsRepository.init();

  await isarJsonHiveImportMigration(defaultDirectory);

  runApp(const ProviderScope(child: MyApp()));
}
