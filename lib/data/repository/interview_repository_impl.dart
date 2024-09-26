import 'package:moi_interview/data/data_source/interview_data_source.dart';
import 'package:moi_interview/domain/repository/interview_repository.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  final InterviewDataSource _interviewDataSource;

  InterviewRepositoryImpl(this._interviewDataSource);
}
