import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_interview/domain/model/question.dart';

part 'detail_ui_state.freezed.dart';

@freezed
class DetailUiState with _$DetailUiState {
  const factory DetailUiState({
    @Default([]) List<Question> questions,
    @Default(false) bool isButtonEnabled,
  }) = _DetailUiState;
}
