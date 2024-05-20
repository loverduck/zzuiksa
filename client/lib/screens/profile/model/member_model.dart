class Member {
  int? memberId;
  String? name;
  String? birthday;
  String? profileImage;

  Member({
    this.memberId,
    this.name,
    this.birthday,
    this.profileImage,
  });

  Member.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    name = json['name'];
    birthday = json['birthday'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['name'] = name;
    if (birthday!=null) data['birthday'] = birthday;
    if (profileImage!=null) data['profileImage'] = profileImage;
    return data;
  }

  @override
  String toString() {
    return "Member: {memberId: $memberId, name: $name, birthday: $birthday, profileImage: $profileImage}";
  }
}
