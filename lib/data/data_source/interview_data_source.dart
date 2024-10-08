import 'package:hive/hive.dart';
import 'package:moi_interview/domain/model/interview.dart';

class InterviewDataSource {
  List<Interview> getInterviews() {
    final box = Hive.box('interviews');
    return box.values.cast<Interview>().toList();
  }

  void addInterview(Interview interview) {
    Hive.box('interviews').put(interview.id, interview);
  }

  void deleteInterview(int interviewId) {
    Hive.box('interviews').delete(interviewId);
  }
}
