class UserSettings {
  String firstName;
  String lastName;
  String avatarPath;
  String theme;
  String language;

  UserSettings({
    required this.firstName,
    required this.lastName,
    required this.avatarPath,
    required this.theme,
    required this.language,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        firstName: json['firstName'],
        lastName: json['lastName'],
        avatarPath: json['avatarPath'],
        theme: json['theme'],
        language: json['language'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'avatarPath': avatarPath,
        'theme': theme,
        'language': language,
      };
}
