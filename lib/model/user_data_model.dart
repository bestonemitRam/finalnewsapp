class UserData {
  dynamic? user_id;
  dynamic user_name;
  dynamic user_mobile;
  dynamic user_token;

  UserData( {
    this.user_id,
    this.user_name,
    this.user_mobile,
    this.user_token,
  });

  factory UserData.fromMap(Map<dynamic, dynamic> data) {
    return UserData(
      user_id: data['user_id'],
      user_name: data['user_name'],
      user_mobile: data['user_mobile'],
      user_token: data['user_token'],
    );
  }
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_mobile: json['user_mobile'],
      user_token: json['user_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_mobile': user_mobile,
      'user_token': user_token,
    };
  }
}
