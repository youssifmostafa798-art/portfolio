import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.dark;
});

final themeToggleProvider = Provider<void Function()>((ref) {
  return () {
    final current = ref.read(themeModeProvider);
    ref.read(themeModeProvider.notifier).state =
        current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  };
});
