import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_saves_backup/core/extensions/theme_extensions.dart';
import 'package:game_saves_backup/core/l10n/l10n_extension.dart';
import 'package:game_saves_backup/core/sync/models/sync_progress.dart';
import 'package:game_saves_backup/core/sync/state/backup_items_state.dart';
import 'package:game_saves_backup/core/sync/state/sync_items_state.dart';
import 'package:game_saves_backup/features/list/ui/list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const _AutoFocusExitButton()),
      body: const _HomeScreenContent(),
      floatingActionButton: const _FAB(),
    );
  }
}

class _AutoFocusExitButton extends ConsumerWidget {
  const _AutoFocusExitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncStatusControllerProvider);

    return switch (state) {
      SyncStatusProgress() => const SizedBox.shrink(),
      SyncStatusReady() => const _ExitButton(),
      SyncStatusCompleted() => const _ExitButton(shouldFocus: true),
    };
  }
}

class _ExitButton extends StatelessWidget {
  const _ExitButton({this.shouldFocus = false});

  final bool shouldFocus;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      focusNode: (shouldFocus ? FocusNode() : null)?..requestFocus(),
      onPressed: () => exit(0),
      icon: const Icon(Icons.close),
    );
  }
}

class _HomeScreenContent extends ConsumerWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasBackupItems = ref.watch(hasBackupItemsProvider);

    return Center(
      child: hasBackupItems ? const _HomeScreenSync() : Text(context.l10n.homeScreenNoBackupItems),
    );
  }
}

class _HomeScreenSync extends ConsumerWidget {
  const _HomeScreenSync();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncStatusControllerProvider);

    return switch (state) {
      SyncStatusReady() => _SyncButton(onSync: ref.read(syncStatusControllerProvider.notifier).sync),
      SyncStatusProgress() => _SyncProgress(state: state),
      SyncStatusCompleted() => _SyncCompleted(
        itemsSynced: state.itemsSynced,
        onDone: ref.read(syncStatusControllerProvider.notifier).reset,
      ),
    };
  }
}

class _SyncButton extends ConsumerWidget {
  const _SyncButton({required this.onSync});

  final VoidCallback onSync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 120,
      width: 120,
      child: FilledButton.icon(
        focusNode: FocusNode()..requestFocus(),
        onPressed: onSync,
        icon: const Icon(Icons.sync),
        label: Text(context.l10n.homeScreenSyncReady),
      ),
    );
  }
}

class _SyncProgress extends StatelessWidget {
  const _SyncProgress({required this.state});

  final SyncStatusProgress state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: LinearProgressIndicator(value: state.progress),
        ),
        Text(context.l10n.homeScreenSyncProgress(state.count, state.total)),
      ],
    );
  }
}

class _SyncCompleted extends StatelessWidget {
  const _SyncCompleted({required this.itemsSynced, required this.onDone});

  final int itemsSynced;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Text('🎉', style: context.textTheme.displayLarge),
        Text(context.l10n.homeScreenSyncCompleted(itemsSynced)),
        TextButton(
          onPressed: onDone,
          child: Text(context.l10n.homeScreenSyncCompletedDone),
        ),
      ],
    );
  }
}

class _FAB extends ConsumerWidget {
  const _FAB();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncStatusControllerProvider);

    return switch (state) {
      SyncStatusProgress() => const SizedBox.shrink(),
      _ => FloatingActionButton.small(
        child: const Icon(Icons.settings),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ListScreen(),
          ),
        ),
      ),
    };
  }
}
