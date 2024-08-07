class UserData {
  dynamic? user_id;
  dynamic user_name;
  dynamic user_email;
  dynamic user_token;

  UserData( {
    this.user_id,
    this.user_name,
    this.user_email,
    this.user_token,
  });

  factory UserData.fromMap(Map<dynamic, dynamic> data) {
    return UserData(
      user_id: data['user_id'],
      user_name: data['user_name'],
      user_email: data['user_email'],
      user_token: data['user_token'],
    );
  }
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_email: json['user_email'],
      user_token: json['user_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_email': user_email,
      'user_token': user_token,
    };
  }
}
