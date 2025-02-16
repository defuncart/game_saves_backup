import 'package:flutter_test/flutter_test.dart';
import 'package:game_saves_backup/core/sync/state/backup_items_state.dart';

void main() {
  group('determineFolderNameForPath', () {
    late String path;

    test('prefix lutris', () {
      path = '/run/media/mmcblk0p1/Games/deus-ex/drive_c/GOG Games/DeusEx/Save';

      expect(determineFolderNameForPath(path), 'deus-ex');
    });

    test('prefix heroic', () {
      path =
          '/run/media/mmcblk0p1/Games/Heroic/Prefixes/HorizonChaseTurbo/drive_c/users/deck/AppData/LocalLow/Aquiris/HorizonChaseTurbo/HorizonChaseTurbo_EpicGameStore/0';

      expect(determineFolderNameForPath(path), 'HorizonChaseTurbo');
    });

    test('steam save (native)', () {
      path = '/home/deck/.steam/steam/userdata/111111111/427820/remote';

      expect(determineFolderNameForPath(path), '427820');
    });

    test('steam save (proton)', () {
      path =
          '/home/deck/.steam/steam/steamapps/compatdata/1599600/pfx/drive_c/users/steamuser/AppData/LocalLow/It\'s Happening/PlateUp/Progress';

      expect(determineFolderNameForPath(path), '1599600');
    });

    test('other', () {
      path = '/home/deck/Desktop/SAVES';

      expect(determineFolderNameForPath(path), 'SAVES');
    });
  });
}
