import 'package:flutter/material.dart';
import 'package:flutter_template/domain/theme/get_theme_mode_use_case.dart';
import 'package:flutter_template/domain/theme/set_theme_mode_use_case.dart';
import 'package:flutter_template/foundation/logger/logger.dart';
import 'package:flutter_template/foundation/unit.dart';
import 'package:flutter_template/interactor/theme/theme_interactor.dart';
import 'package:flutter_template/interactor/theme/theme_mode_mapper.dart';

class ThemeInteractorImpl implements ThemeInteractor {
  final SetThemeModeUseCase setThemeModeUseCase;
  final GetThemeModeUseCase getThemeModeUseCase;
  final ThemeModeMapper themeModeMapper;

  ThemeInteractorImpl({
    required this.setThemeModeUseCase,
    required this.getThemeModeUseCase,
    required this.themeModeMapper,
  });

  @override
  ThemeMode getThemeMode() {
    final appThemeMode = getThemeModeUseCase(unit);
    return appThemeMode.when(
      success: (mode) => themeModeMapper.map(mode),
      error: (error) {
        log.e(error);
        return ThemeMode.system;
      },
    );
  }

  @override
  Future setThemeMode(ThemeMode themeMode) async {
    return setThemeModeUseCase(
      param: themeModeMapper.mapThemeMode(themeMode),
    );
  }
}
