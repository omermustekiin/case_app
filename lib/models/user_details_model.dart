import 'dart:typed_data';

class UserDetailsModel {
  final String? name;
  final String email;
  final int? age;
  final bool? gender; //true==male, false==female
  final String? bio;
  final Uint8List? image;



  UserDetailsModel({ this.name, required this.email, this.age, this.gender=true, this.bio, this.image});

  Map<String, dynamic> getJson() => {
    'name': name,
    'email': email,
    'age': age,
    'gender': gender,
    'bio': bio,
    'image': image,
  };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], email: json["email"], age: json["age"], gender: json["gender"], bio: json["bio"], image: json["image"]);
  }
}