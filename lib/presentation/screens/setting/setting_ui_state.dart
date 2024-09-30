import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_interview/domain/model/user.dart';

part 'setting_ui_state.freezed.dart';

@freezed
class SettingUiState with _$SettingUiState {
  const factory SettingUiState({
    User? user,
    @Default(false) bool isButtonEnabled,
  }) = _SettingUiState;
}
