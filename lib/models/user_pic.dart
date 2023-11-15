class UserPic {
  final String large;
  final String medium;
  final String thumbnail;

  UserPic({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory UserPic.fromMap(Map<String, dynamic> json) {
    return UserPic(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
