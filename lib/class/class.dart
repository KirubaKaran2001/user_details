import 'package:hive/hive.dart';
part 'class.g.dart';

@HiveType(typeId: 0)
class UserDetails extends HiveObject {

  @HiveField(0)
  
  String? name;
  
  @HiveField(1)
  
  double? age;
  
  @HiveField(2)
  
  DateTime? dob;
}
