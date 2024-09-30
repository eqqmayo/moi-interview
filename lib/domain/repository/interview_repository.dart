import 'package:moi_interview/domain/model/interview.dart';

abstract interface class InterviewRepository {
  List<Interview> getInterviews();

  void addInterview(Interview interview);
}
