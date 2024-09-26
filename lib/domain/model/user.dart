import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String word;

  @HiveField(2)
  String? interviewerImgPath;

  User({
    required this.name,
    required this.word,
    this.interviewerImgPath,
  });
}
