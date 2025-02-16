import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_saves_backup/core/sync/models/backup_item.dart';
import 'package:game_saves_backup/core/sync/repositories/items_repository.dart';
import 'package:game_saves_backup/core/sync/repositories/uuid_repository.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_items_state.g.dart';

@riverpod
ItemsRepository _itemsRepository(Ref ref) => HiveItemsRepository();

@riverpod
UUIDRepository _uuidRepository(Ref ref) => UUIDRepositoryImpl();

@riverpod
class BackupItems extends _$BackupItems {
  List<BackupItem> _getAllItems() => ref.read(_itemsRepositoryProvider).getAllItems().toList();

  @override
  List<BackupItem> build() => _getAllItems();

  void add({required String path}) {
    final id = ref.read(_uuidRepositoryProvider).generate();
    final folderName = determineFolderNameForPath(path);
    ref.read(_itemsRepositoryProvider).addItem(BackupItem(id: id, path: path, folderName: folderName));
    state = _getAllItems();
  }

  void updateName({required BackupItem item, required String folderName}) {
    final newItem = item.updateFolderName(folderName);
    ref.read(_itemsRepositoryProvider).addItem(newItem);
    state = _getAllItems();
  }

  void remove(String id) {
    ref.read(_itemsRepositoryProvider).removeItem(id);
    state = _getAllItems();
  }
}

@visibleForTesting
String determineFolderNameForPath(String path) {
  final steamProtonRegex = RegExp(r'compatdata\/(\d+)\/pfx/drive_c');

  if (steamProtonRegex.hasMatch(path)) {
    final matches = steamProtonRegex.firstMatch(path);
    if (matches != null && matches.groupCount >= 1 && matches.group(1) != null && matches.group(1)!.isNotEmpty) {
      return matches.group(1)!;
    }
  }

  final steamNativeRegex = RegExp(r'userdata\/\d+\/(\d+)/remote');
  final matches = steamNativeRegex.firstMatch(path);
  if (matches != null && matches.groupCount >= 1 && matches.group(1) != null && matches.group(1)!.isNotEmpty) {
    return matches.group(1)!;
  }

  final pathComponents = p.split(path);
  // prefix
  if (pathComponents.indexOf('drive_c') > 0) {
    return pathComponents.sublist(0, pathComponents.indexOf('drive_c')).last;
  }

  return pathComponents.last;
}

@riverpod
bool hasBackupItems(Ref ref) => ref.watch(backupItemsProvider).isNotEmpty;

extension on BackupItem {
  BackupItem updateFolderName(String folderName) => BackupItem(id: id, folderName: folderName, path: path);
}
