import 'package:moi_interview/data/data_source/question_data_source.dart';
import 'package:moi_interview/domain/repository/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDataSource _questionDataSource;

  QuestionRepositoryImpl(this._questionDataSource);
}
