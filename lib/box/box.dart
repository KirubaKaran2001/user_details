import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_details/class/class.dart';

class Boxes {
  static Box<UserDetails> getdetails() =>
      Hive.box<UserDetails>('userDetail');
}