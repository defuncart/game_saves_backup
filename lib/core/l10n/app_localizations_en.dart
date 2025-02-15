// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myKey => 'Hello world!';

  @override
  String get homeScreenNoBackupItems => 'No items to back up';

  @override
  String get homeScreenSyncReady => 'Sync';

  @override
  String homeScreenSyncProgress(Object count, Object total) {
    return 'Syncing $count/$total...';
  }

  @override
  String homeScreenSyncCompleted(num itemsSynced) {
    String _temp0 = intl.Intl.pluralLogic(
      itemsSynced,
      locale: localeName,
      other: '$itemsSynced items synced',
      one: '$itemsSynced item synced!',
    );
    return '$_temp0';
  }

  @override
  String get homeScreenSyncCompletedDone => 'Done';

  @override
  String get listScreenTitle => 'Game List';

  @override
  String get listScreenActionTooltipCreateNewFoldersEnabled => 'Each sync backs up to a timestamp folder ';

  @override
  String get listScreenActionTooltipCreateNewFoldersDisabled => 'Each sync overwrites existing backup ';

  @override
  String get listScreenActionTooltipSyncDirectory => 'Directory to sync backups';

  @override
  String get listScreenNoBackupItems => 'Add an item to get started';

  @override
  String get listScreenNewBackupItemSelectText => 'Select';

  @override
  String get listScreenBackupItemOpen => 'Open';

  @override
  String get listScreenBackupItemCopyPath => 'Copy path';

  @override
  String get listScreenBackupItemEdit => 'Edit';

  @override
  String get listScreenBackupItemRemove => 'Remove';

  @override
  String get listScreenBackupItemNameHintText => 'Name';

  @override
  String get listScreenBackupItemNameUnsavedChangesWarning => 'Unsaved changes';
}
