import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User(
      {required this.name,
      required this.email,
      required this.surname,
      required this.photolink});

  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String surname;

  @HiveField(3)
  String photolink;
}
