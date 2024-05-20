class Login {
  String? accessToken;
  int? expiresIn;

  Login({
    this.accessToken,
    this.expiresIn,
  });

  Login.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['expiresIn'] = expiresIn;
    return data;
  }

  @override
  String toString() {
    return "LoginResponse: {accessToken: $accessToken, expiresIn: $expiresIn}";
  }
}