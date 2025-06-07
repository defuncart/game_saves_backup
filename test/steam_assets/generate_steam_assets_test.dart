import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:flutter/material.dart';
import 'package:game_saves_backup/core/extensions/theme_extensions.dart';
import 'package:game_saves_backup/core/theme/themes.dart';

void main() {
  generateSteamIcon(
    onBuildIcon: (size) => SteamAsset(
      size: size,
      showIcon: true,
      showText: false,
    ),
  );

  generateSteamCover(
    onBuildCover: (size) => SteamAsset(
      size: size,
      showIcon: true,
      showText: false,
    ),
  );

  generateSteamHero(
    onBuildHero: (size) => SteamAsset(
      size: size,
      showIcon: false,
      showText: false,
    ),
  );

  generateSteamLogo(
    onBuildLogo: (size) => SteamAsset(
      size: size,
      showIcon: true,
      showText: false,
      isBackgroundTransparent: true,
    ),
  );

  generateSteamBanner(
    onBuildBanner: (size) => SteamAsset(
      size: size,
      showIcon: true,
      showText: true,
    ),
  );
}

class SteamAsset extends StatelessWidget {
  const SteamAsset({
    super.key,
    required this.size,
    required this.showText,
    required this.showIcon,
    this.isBackgroundTransparent = false,
  });

  final Size size;
  final bool showText;
  final bool showIcon;
  final bool isBackgroundTransparent;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: Builder(
        builder: (context) => Container(
          width: size.width,
          height: size.height,
          color: isBackgroundTransparent ? Colors.transparent : Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 128,
              children: [
                if (showIcon)
                  Icon(
                    Icons.backup,
                    color: context.colorScheme.primary,
                    size: size.shortestSide * 0.6,
                  ),
                if (showText)
                  Text(
                    'Game\nSaves\nBackup',
                    style: TextStyle(
                      fontSize: size.shortestSide * 0.6 * 0.1825,
                      color: context.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
