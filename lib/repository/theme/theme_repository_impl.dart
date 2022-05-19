import 'package:flutter_template/domain/entity/preferences/preference_keys.dart';
import 'package:flutter_template/domain/entity/theme/theme_mode.dart';
import 'package:flutter_template/repository/preferences/preferences_repository.dart';
import 'package:flutter_template/repository/theme/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final PreferencesRepository preferencesRepo;

  ThemeRepositoryImpl({required this.preferencesRepo});

  @override
  AppThemeMode getThemeMode() {
    final themeMode = preferencesRepo.getString(
      key: PreferenceKeys.themeMode.key,
      defaultValue: AppThemeMode.system.serializedValue,
    );
    return AppThemeMode.values.firstWhere(
      (mode) => mode.serializedValue == themeMode,
    );
  }

  @override
  Future setThemeMode({required AppThemeMode themeMode}) async {
    return await preferencesRepo.save(
      key: PreferenceKeys.themeMode.key,
      value: themeMode.serializedValue,
    );
  }
}
