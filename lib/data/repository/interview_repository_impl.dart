import 'package:moi_interview/data/data_source/interview_data_source.dart';
import 'package:moi_interview/domain/model/interview.dart';
import 'package:moi_interview/domain/repository/interview_repository.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  final InterviewDataSource _interviewDataSource;

  InterviewRepositoryImpl(this._interviewDataSource);

  @override
  List<Interview> getInterviews() {
    return _interviewDataSource.getInterviews();
  }

  @override
  void addInterview(Interview interview) {
    _interviewDataSource.addInterview(interview);
  }

  @override
  void deleteInterview(int interviewId) {
    _interviewDataSource.deleteInterview(interviewId);
  }
}
