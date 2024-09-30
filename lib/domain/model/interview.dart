import 'package:hive/hive.dart';

part 'interview.g.dart';

@HiveType(typeId: 1)
class Interview extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  Interview({
    required this.id,
    required this.title,
  });
}
