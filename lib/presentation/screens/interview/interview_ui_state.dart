import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_interview/domain/model/user.dart';

part 'interview_ui_state.freezed.dart';

@freezed
class InterviewUiState with _$InterviewUiState {
  const factory InterviewUiState({
    User? user,
    @Default(0) int currentQuestionIndex,
  }) = _InterviewUiState;
}
