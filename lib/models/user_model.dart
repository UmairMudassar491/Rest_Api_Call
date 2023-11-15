import 'package:slider_task/models/user_dob.dart';
import 'package:slider_task/models/user_location.dart';
import 'package:slider_task/models/user_name.dart';
import 'package:slider_task/models/user_pic.dart';

class UserModel {
  final UserName name;
  final String email;
  final UserLocation location;
  final UserDob dob;
  final String cell;
  final String phone;
  final UserPic pic;
  final String gender;
  UserModel({
    required this.name,
    required this.email,
    required this.location,
    required this.dob,
    required this.cell,
    required this.phone,
    required this.pic,
    required this.gender,
  });

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }

  String get fullStreet {
    return 'Str no ${location.street.number} ${location.street.name} ';
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    final name = UserName.fromMap(json['name']);
    final dob = UserDob.fromMap(json['dob']);
    final pic = UserPic.fromMap(json['picture']);
    final location = UserLocation.fromMap(json['location']);

    return UserModel(
      name: name,
      email: json['email'],
      location: location,
      dob: dob,
      cell: json['cell'],
      phone: json['phone'],
      pic: pic,
      gender: json['gender'],
    );
  }
}
