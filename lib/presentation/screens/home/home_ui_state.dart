import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/model/user.dart';

part 'home_ui_state.freezed.dart';

@freezed
class HomeUiState with _$HomeUiState {
  const factory HomeUiState({
    User? user,
    @Default([]) List<Interview> interviews,
  }) = _HomeUiState;
}
