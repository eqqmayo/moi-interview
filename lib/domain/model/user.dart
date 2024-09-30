import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String word;

  @HiveField(2)
  final String? interviewerImgPath;

  User({
    required this.name,
    required this.word,
    this.interviewerImgPath,
  });

  User copyWith({
    String? name,
    String? word,
    String? interviewerImgPath,
  }) {
    return User(
      name: name ?? this.name,
      word: word ?? this.word,
      interviewerImgPath: interviewerImgPath ?? this.interviewerImgPath,
    );
  }
}
