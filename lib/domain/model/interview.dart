import 'package:hive/hive.dart';

part 'interview.g.dart';

@HiveType(typeId: 1)
class Interview extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  Interview({
    required this.id,
    required this.title,
  });
}
