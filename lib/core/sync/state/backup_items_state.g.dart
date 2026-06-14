// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_items_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemsRepositoryHash() => r'05fb67d3ee30b8b56c30f2c2becdf9274afc1c87';

/// See also [_itemsRepository].
@ProviderFor(_itemsRepository)
final _itemsRepositoryProvider = AutoDisposeProvider<ItemsRepository>.internal(
  _itemsRepository,
  name: r'_itemsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _ItemsRepositoryRef = AutoDisposeProviderRef<ItemsRepository>;
String _$uuidRepositoryHash() => r'ed211644c416b7ac85b6494d4bcc8a8c9ecaa8c8';

/// See also [_uuidRepository].
@ProviderFor(_uuidRepository)
final _uuidRepositoryProvider = AutoDisposeProvider<UUIDRepository>.internal(
  _uuidRepository,
  name: r'_uuidRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uuidRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _UuidRepositoryRef = AutoDisposeProviderRef<UUIDRepository>;
String _$hasBackupItemsHash() => r'11f9125c509859fee975c936eb6b913d8d716027';

/// See also [hasBackupItems].
@ProviderFor(hasBackupItems)
final hasBackupItemsProvider = AutoDisposeProvider<bool>.internal(
  hasBackupItems,
  name: r'hasBackupItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasBackupItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasBackupItemsRef = AutoDisposeProviderRef<bool>;
String _$backupItemsHash() => r'd61df212941328b6e729a69f1f7390156aa4e8e7';

/// See also [BackupItems].
@ProviderFor(BackupItems)
final backupItemsProvider =
    AutoDisposeNotifierProvider<BackupItems, List<BackupItem>>.internal(
  BackupItems.new,
  name: r'backupItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$backupItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BackupItems = AutoDisposeNotifier<List<BackupItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
