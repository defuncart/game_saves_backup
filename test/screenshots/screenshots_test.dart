import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_saves_backup/core/l10n/generated/app_localizations.dart';
import 'package:game_saves_backup/core/sync/models/backup_item.dart';
import 'package:game_saves_backup/core/sync/models/sync_progress.dart';
import 'package:game_saves_backup/core/sync/state/backup_items_state.dart';
import 'package:game_saves_backup/core/sync/state/sync_items_state.dart';
import 'package:game_saves_backup/core/theme/themes.dart';
import 'package:game_saves_backup/features/home/ui/home_screen.dart';

void main() {
  const textStyle = TextStyle(fontSize: 96, color: Colors.white);

  generateAppStoreScreenshots(
    config: ScreenshotsConfig(
      devices: [DeviceType.linux],
      locales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      background: ScreenshotBackground.solid(color: Colors.transparent),
      theme: darkTheme,
      textOptions: const ScreenshotTextOptions(textStyle: textStyle),
    ),
    screens: [
      ScreenshotScenario(
        onBuildScreen: () => const HomeScreen(),
        onPostPumped: (tester) async {
          await tester.tap(find.byType(FloatingActionButton));
        },
        wrapper:
            (child) => ProviderScope(
              overrides: [
                hasBackupItemsProvider.overrideWithValue(true),
                syncCreateNewFoldersControllerProvider.overrideWith(() => FakeSyncCreateNewFoldersController()),
                backupItemsProvider.overrideWith(() => FakeBackupItems()),
              ],
              child: child,
            ),
        isFrameVisible: true,
      ),
      ScreenshotScenario(
        onBuildScreen: () => const HomeScreen(),
        wrapper: (child) => ProviderScope(overrides: [hasBackupItemsProvider.overrideWithValue(true)], child: child),
        isFrameVisible: true,
      ),
      ScreenshotScenario(
        onBuildScreen: () => const HomeScreen(),
        wrapper:
            (child) => ProviderScope(
              overrides: [
                hasBackupItemsProvider.overrideWithValue(true),
                syncStatusControllerProvider.overrideWith(() => FakeSyncStatusController()),
              ],
              child: child,
            ),
        isFrameVisible: true,
      ),
    ],
  );
}

class FakeSyncCreateNewFoldersController extends SyncCreateNewFoldersController {
  @override
  bool build() => true;
}

class FakeBackupItems extends BackupItems {
  @override
  List<BackupItem> build() => const [
    BackupItem(
      id: 'id1',
      path:
          '/run/media/mmcblk0p1/Games/Heroic/Prefixes/HorizonChaseTurbo/drive_c/users/deck/AppData/LocalLow/Aquiris/HorizonChaseTurbo/HorizonChaseTurbo_EpicGameStore/0',
      folderName: 'HorizonChaseTurbo',
    ),
    BackupItem(
      id: 'id2',
      path: '/run/media/mmcblk0p1/Games/deus-ex/drive_c/GOG Games/DeusEx/Save',
      folderName: 'deus-ex',
    ),
  ];
}

class FakeSyncStatusController extends SyncStatusController {
  @override
  SyncStatus build() => const SyncStatusCompleted(itemsSynced: 2);
}
