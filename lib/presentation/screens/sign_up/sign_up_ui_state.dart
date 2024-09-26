import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_interview/domain/model/user.dart';

part 'sign_up_ui_state.freezed.dart';

@freezed
class SignUpUiState with _$SignUpUiState {
  const factory SignUpUiState({
    User? user,
    @Default(false) bool isButtonEnabled,
  }) = _SignUpUiState;
}
